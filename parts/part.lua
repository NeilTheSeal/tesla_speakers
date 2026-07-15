-- Sealed two-way prototype speaker enclosure.
-- X = cabinet width, Y = cabinet length, Z = height.

local inch = 25.4

-- Cabinet geometry. The 410 mm length keeps this one-piece model within the
-- stated 420 x 420 x 480 mm printer build volume.
local outside_width = param("Outside width", 9.5 * inch)
local cabinet_length = param("Cabinet length", 410)
local wall_thickness = param("Wall thickness", 8)
local vertical_wall_height = param("Vertical wall height", 210)
-- A 45 degree roof slope gives the two driver axes a 90 degree included angle.
local roof_angle = param("Roof angle", 0)
local divider_y = param("Woofer chamber length", 270)
local divider_thickness = param("Divider thickness", 8)
local baffle_thickness = param("Raised baffle thickness", 12)
local baffle_margin = param("Raised baffle margin", 6)
local baffle_side_inset = param("Raised baffle side inset", 2)

-- Check these against the supplied manufacturer CAD before printing.
local woofer_cutout_diameter = param("Woofer cutout diameter", 185)
local woofer_frame_diameter = param("Woofer frame diameter", 225)
local woofer_bolt_circle = param("Woofer bolt circle", 210)
local woofer_mount_count = param("Woofer mount count", 8)
local woofer_center_y = param("Woofer center Y", 140)

local midrange_cutout_diameter = param("Midrange cutout diameter", 98)
local midrange_frame_diameter = param("Midrange frame diameter", 120)
local midrange_bolt_circle = param("Midrange bolt circle", 106)
local midrange_mount_count = param("Midrange mount count", 6)
local midrange_center_y = param("Midrange center Y", 340)
local mounting_hole_diameter = param("Mounting hole diameter", 4.4)

local roof_radians = math.rad(roof_angle)
local half_width = outside_width / 2
local roof_rise = half_width * math.tan(roof_radians)
local total_height = vertical_wall_height + roof_rise

-- Build an XZ profile and extrude it along +Y.
local function section(profile, length)
	return translate(rotate_x(extrude(profile, length), 90), 0, length, 0)
end

local outer_profile = poly_xy({
	{ -half_width, 0 },
	{ half_width, 0 },
	{ half_width, vertical_wall_height },
	{ 0, total_height },
	{ -half_width, vertical_wall_height },
})

-- Offset the inner roof faces normal to the outer roof faces. This retains a
-- consistent wall thickness rather than merely shrinking the outer profile.
local inner_half_width = half_width - wall_thickness
local inner_peak_height = total_height - wall_thickness / math.cos(roof_radians)
local inner_eave_height = total_height
	- math.tan(roof_radians) * inner_half_width
	- wall_thickness / math.cos(roof_radians)
local inner_profile = poly_xy({
	{ -inner_half_width, wall_thickness },
	{ inner_half_width, wall_thickness },
	{ inner_half_width, inner_eave_height },
	{ 0, inner_peak_height },
	{ -inner_half_width, inner_eave_height },
})

local outer_shell = section(outer_profile, cabinet_length)
local inner_cavity = translate(
	section(inner_profile, cabinet_length - 2 * wall_thickness),
	0,
	wall_thickness,
	0
)
local cabinet = difference(outer_shell, inner_cavity)

-- The full-depth divider gives the midrange its own sealed chamber, preventing
-- woofer back-wave pressure from modulating the midrange cone.
local divider = translate(section(outer_profile, divider_thickness), 0, divider_y, 0)
cabinet = union(cabinet, divider)

local function roof_height(x)
	return total_height - math.tan(roof_radians) * math.abs(x)
end

-- A cutter whose axis follows a roof-face normal. side is -1 for the left roof
-- and +1 for the right roof.
local function roof_cutter(diameter, inside_depth, outside_depth, center_x, center_y, center_z, side)
	local angle = side * roof_angle
	local angle_radians = math.rad(angle)
	local cutter = cylinder(diameter, inside_depth + outside_depth)
	cutter = rotate_y(cutter, angle)
	return translate(
		cutter,
		center_x - math.sin(angle_radians) * inside_depth,
		center_y,
		center_z - math.cos(angle_radians) * inside_depth
	)
end

-- The raised baffle carries frames wider than a single 45 degree roof panel.
-- It overlaps the cabinet by 0.8 mm so the boolean union remains robust.
local function roof_baffle(diameter, center_x, center_y, center_z, side)
	local angle = side * roof_angle
	local angle_radians = math.rad(angle)
	local baffle = cylinder(diameter, baffle_thickness + 0.8)
	baffle = rotate_y(baffle, angle)
	return translate(
		baffle,
		center_x - math.sin(angle_radians) * 0.8,
		center_y,
		center_z - math.cos(angle_radians) * 0.8
	)
end

local function add_driver_cuts(cuts, baffles, side, center_y, frame_diameter, cutout_diameter, bolt_circle, mount_count)
	local baffle_radius = frame_diameter / 2 + baffle_margin
	local baffle_outer_x = baffle_radius * math.cos(roof_radians)
		+ baffle_thickness * math.sin(roof_radians)
	local center_x = side * (half_width - baffle_outer_x - baffle_side_inset)
	local center_z = roof_height(center_x)
	local inside_depth = wall_thickness + 2
	local outside_depth = 20

	table.insert(
		baffles,
		roof_baffle(
			frame_diameter + 2 * baffle_margin,
			center_x,
			center_y,
			center_z,
			side
		)
	)

	table.insert(
		cuts,
		roof_cutter(
			cutout_diameter,
			inside_depth,
			outside_depth,
			center_x,
			center_y,
			center_z,
			side
		)
	)

	local angle_radians = side * roof_radians
	local bolt_radius = bolt_circle / 2
	for index = 0, mount_count - 1 do
		local theta = 2 * math.pi * index / mount_count
		local roof_axis_offset = bolt_radius * math.cos(theta)
		local y_offset = bolt_radius * math.sin(theta)
		local hole_x = center_x + math.cos(angle_radians) * roof_axis_offset
		local hole_z = center_z - math.sin(angle_radians) * roof_axis_offset
		table.insert(
			cuts,
			roof_cutter(
				mounting_hole_diameter,
				inside_depth,
				outside_depth,
				hole_x,
				center_y + y_offset,
				hole_z,
				side
			)
		)
	end
end

local cuts = {}
local baffles = {}
add_driver_cuts(
	cuts,
	baffles,
	-1,
	woofer_center_y,
	woofer_frame_diameter,
	woofer_cutout_diameter,
	woofer_bolt_circle,
	woofer_mount_count
)
add_driver_cuts(
	cuts,
	baffles,
	1,
	midrange_center_y,
	midrange_frame_diameter,
	midrange_cutout_diameter,
	midrange_bolt_circle,
	midrange_mount_count
)

cabinet = union(cabinet, table.unpack(baffles))
cabinet = difference(cabinet, union(table.unpack(cuts)))
emit(cabinet)
