-- Sealed two-way prototype speaker enclosure.
-- X = cabinet width, Y = cabinet length, Z = height.

local inch = 25.4

-- Cabinet geometry. The 410 mm length keeps this one-piece model within the
-- stated 420 x 420 x 480 mm printer build volume.
local outside_width = param("Outside width", 9.5 * inch)
local cabinet_length = param("Cabinet length", 410)
local wall_thickness = param("Wall thickness", 8)
local vertical_wall_height = param("Vertical wall height", 150)
-- A 45 degree roof slope gives the two driver axes a 90 degree included angle.
local roof_angle = param("Roof angle", 0)
local divider_y = param("Woofer chamber length", 270)
local divider_thickness = param("Divider thickness", 8)
local baffle_thickness = param("Raised baffle thickness", 12)
local baffle_margin = param("Raised baffle margin", 6)
local baffle_side_inset = param("Raised baffle side inset", 2)

-- Check these against the supplied manufacturer CAD before printing.
local woofer_cutout_diameter = param("Woofer cutout diameter", 194.1)
local woofer_frame_diameter = param("Woofer frame diameter", 222)
local woofer_bolt_radius = param("Woofer bolt radius", 105)
local woofer_mount_hole_diameter = param("Woofer mount hole diameter", 5.2)
local woofer_center_y = param("Woofer center Y", 140)

local midrange_cutout_diameter = param("Midrange cutout diameter", 101)
local midrange_frame_diameter = param("Midrange frame diameter", 120)
local midrange_bolt_radius = param("Midrange bolt radius", 55.8)
local midrange_mount_hole_diameter = param("Midrange mount hole diameter", 4.5)
local midrange_center_y = param("Midrange center Y", 340)
local wire_pass_through_diameter = param("Wire pass-through diameter", 12.5)
local wire_pass_through_height = param("Wire pass-through height", 30)
local wire_wall_side = param("Wire wall side", -1)
local box_edge_chamfer = param("Box edge chamfer", 3)
local foot_diameter = param("Foot diameter", 1.5 * inch)
local foot_height = param("Foot height", 1.0 * inch)
local foot_corner_inset = param("Foot corner inset", 8)
local isolation_pad_diameter = param("Isolation pad diameter", 1.0625 * inch)
local isolation_pad_recess_depth = param("Isolation pad recess depth", 0.25 * inch)
local foot_edge_chamfer = param("Foot edge chamfer", 1.5)
local wire_hole_chamfer = param("Wire hole chamfer", 1)
local emblem_engraving_depth = param("Emblem engraving depth", 0.125 * inch)
local emblem_center_x = param("Emblem center X", -70)
local emblem_center_y = param("Emblem center Y", cabinet_length - 75)

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

local outer_shell = chamfer_all(section(outer_profile, cabinet_length), box_edge_chamfer)
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

-- One wire pass-through per sealed chamber, located in the lower portion of
-- the long side wall. Install a grommet or seal the wires after final wiring.
local function wire_pass_through(center_y)
	local cutter_length = wall_thickness + 4
	local cutter = cylinder(wire_pass_through_diameter, cutter_length)
	cutter = rotate_y(cutter, wire_wall_side * 90)
	return translate(
		cutter,
		wire_wall_side * (half_width - wall_thickness - 2),
		center_y,
		wire_pass_through_height
	)
end

-- Feet extend downward from the box bottom. Their open-bottom recesses hold
-- 0.25 in Sorbothane discs flush with the floor-contact surface.
local function isolation_foot(center_x, center_y)
	local foot = chamfer_all(cylinder(foot_diameter, foot_height + 0.8), foot_edge_chamfer)
	foot = translate(foot, center_x, center_y, -foot_height)
	local recess = translate(
		cylinder(isolation_pad_diameter, isolation_pad_recess_depth + 0.2),
		center_x,
		center_y,
		-foot_height - 0.1
	)
	return foot, recess
end

-- Art-deco NH monogram made from tapered polygonal letter strokes.
local function monogram_emblem()
	local cutter_height = emblem_engraving_depth + 0.2
	local cutter_z = total_height - emblem_engraving_depth
	local function stroke(points)
		return extrude(poly_xy(points), cutter_height)
	end

	local monogram = union(
		-- N
		stroke({ { -40, -32 }, { -32, -32 }, { -24, 32 }, { -32, 32 } }),
		stroke({ { -12, -32 }, { -4, -32 }, { 2, 32 }, { -6, 32 } }),
		stroke({ { -30, 32 }, { -22, 32 }, { -4, -32 }, { -12, -32 } }),
		-- H
		stroke({ { 7, -32 }, { 14, -32 }, { 17, 32 }, { 10, 32 } }),
		stroke({ { 32, -32 }, { 40, -32 }, { 40, 32 }, { 32, 32 } }),
		stroke({ { 12, -4 }, { 36, -4 }, { 36, 4 }, { 12, 4 } })
	)
	monogram = rotate_z(monogram, -90)
	return translate(monogram, emblem_center_x, emblem_center_y, cutter_z)
end

local function add_driver_cuts(cuts, baffles, side, center_y, frame_diameter, cutout_diameter, bolt_radius, bolt_hole_diameter, bolt_angles)
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
	for _, angle_degrees in ipairs(bolt_angles) do
		local theta = math.rad(angle_degrees)
		local roof_axis_offset = bolt_radius * math.cos(theta)
		local y_offset = bolt_radius * math.sin(theta)
		local hole_x = center_x + math.cos(angle_radians) * roof_axis_offset
		local hole_z = center_z - math.sin(angle_radians) * roof_axis_offset
		table.insert(
			cuts,
			roof_cutter(
				bolt_hole_diameter,
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
local feet = {}
local foot_recesses = {}
local foot_radius = foot_diameter / 2
local foot_x = half_width - foot_radius - foot_corner_inset
local foot_y = foot_radius + foot_corner_inset
local foot_positions = {
	{ -foot_x, foot_y },
	{ foot_x, foot_y },
	{ -foot_x, cabinet_length - foot_y },
	{ foot_x, cabinet_length - foot_y },
}
for _, position in ipairs(foot_positions) do
	local foot, recess = isolation_foot(position[1], position[2])
	table.insert(feet, foot)
	table.insert(foot_recesses, recess)
end

local woofer_bolt_angles = {}
for index = 0, 6 do
	table.insert(woofer_bolt_angles, 360 * index / 7)
end

local midrange_bolt_angles = { -15, 15, 105, 135, 225, 255 }

add_driver_cuts(
	cuts,
	baffles,
	-1,
	woofer_center_y,
	woofer_frame_diameter,
	woofer_cutout_diameter,
	woofer_bolt_radius,
	woofer_mount_hole_diameter,
	woofer_bolt_angles
)
add_driver_cuts(
	cuts,
	baffles,
	1,
	midrange_center_y,
	midrange_frame_diameter,
	midrange_cutout_diameter,
	midrange_bolt_radius,
	midrange_mount_hole_diameter,
	midrange_bolt_angles
)

table.insert(cuts, wire_pass_through(woofer_center_y))
table.insert(cuts, wire_pass_through(midrange_center_y))
table.insert(cuts, monogram_emblem())
for _, recess in ipairs(foot_recesses) do
	table.insert(cuts, recess)
end

cabinet = union(cabinet, table.unpack(feet))
cabinet = union(cabinet, table.unpack(baffles))
cabinet = difference(cabinet, union(table.unpack(cuts)))

local wire_wall_face = wire_wall_side < 0 and "xmin" or "xmax"
local wire_hole_edges = edges(cabinet):on_box_side(wire_wall_face):geom("circle"):collect()
cabinet = chamfer(cabinet, wire_hole_edges, wire_hole_chamfer)
emit(cabinet)
