-- Sealed two-way prototype speaker enclosure.
-- X = cabinet width, Y = cabinet length, Z = height.

local inch = 25.4

-- Cabinet geometry. The 410 mm length keeps this one-piece model within the
-- stated 420 x 420 x 480 mm printer build volume.
local outside_width = param("Outside width", 9.5 * inch)
local cabinet_length = param("Cabinet length", 460)
local wall_thickness = param("Wall thickness", 8)
local cabinet_height = param("Cabinet height", 240)
local divider_y = param("Woofer chamber length", 266)
local divider_thickness = param("Divider thickness", 8)
local woofer_brace_y = param("Woofer window brace Y", 240)
local woofer_brace_thickness = param("Woofer window brace thickness", 8)
local woofer_brace_window_width = param("Woofer brace window width", 160)
local woofer_brace_window_height = param("Woofer brace window height", 90)
local baffle_thickness = param("Raised baffle thickness", 12)
local baffle_margin = param("Raised baffle margin", 6)
local baffle_side_inset = param("Raised baffle side inset", 2)
local trim_ring_height = param("Baffle trim ring height", 2)
local trim_ring_width = param("Baffle trim ring width", 3)
local trim_ring_overlap = param("Baffle trim ring overlap", 0.8)
local side_rib_depth = param("Side rib depth", 2.5)
local side_rib_width = param("Side rib width", 8)
local side_rib_end_clearance = param("Side rib end clearance", 14)
local corner_bumper_diameter = param("Corner bumper diameter", 12)
local corner_bumper_projection = param("Corner bumper projection", 1.5)
local corner_bumper_chamfer = param("Corner bumper chamfer", 1.5)

-- Check these against the supplied manufacturer CAD before printing.
local woofer_cutout_diameter = param("Woofer cutout diameter", 194.1)
local woofer_frame_diameter = param("Woofer frame diameter", 222)
local woofer_bolt_radius = param("Woofer bolt radius", 105)
local woofer_mount_hole_diameter = param("Woofer mount hole diameter", 5.2)
local woofer_center_y = param("Woofer center Y", 140)
local woofer_x_offset = param("Woofer X offset", 2)
local woofer_rear_chamfer = param("Woofer rear cutout chamfer", 3)

local midrange_cutout_diameter = param("Midrange cutout diameter", 101)
local midrange_frame_diameter = param("Midrange frame diameter", 120)
local midrange_bolt_radius = param("Midrange bolt radius", 55.8)
local midrange_mount_hole_diameter = param("Midrange mount hole diameter", 4.5)
local midrange_center_y = param("Midrange center Y", 391)
local midrange_x_offset = param("Midrange X offset", -2)
local midrange_rear_chamfer = param("Midrange rear cutout chamfer", 2)
local wire_pass_through_diameter = param("Wire pass-through diameter", 12.5)
local wire_pass_through_height = param("Wire pass-through height", 30)
local wire_wall_side = param("Wire wall side", -1)
local box_edge_chamfer = param("Box edge chamfer", 3)
local foot_diameter = param("Foot diameter", 1.5 * inch)
local foot_height = param("Foot height", 0.75 * inch)
local foot_corner_inset = param("Foot corner inset", 8)
local foot_collar_height = param("Foot collar height", 6)
local foot_collar_flare = param("Foot collar flare", 5)
local bottom_brace_height = param("Bottom cross-brace height", 6)
local bottom_brace_width = param("Bottom cross-brace width", 12)
local bottom_brace_foot_overlap = param("Bottom cross-brace foot overlap", 12)
local isolation_pad_diameter = param("Isolation pad diameter", 1.0625 * inch)
local isolation_pad_recess_depth = param("Isolation pad recess depth", 0.25 * inch)
local foot_edge_chamfer = param("Foot edge chamfer", 1.5)
local wire_hole_chamfer = param("Wire hole chamfer", 1)
-- Tweeter mounting geometry. The through-hole into the chamber only needs about
-- 77 mm; the default 85 mm cutout leaves a little wiggle room. The 104.25 mm
-- mounting bracket is the outer flange the baffle must support, which is the
-- direct analog of the woofer/midrange frame diameter. Bolt holes are deferred
-- until their exact locations are measured in SolidWorks.
local tweeter_cutout_diameter = param("Tweeter cutout diameter", 85)
local tweeter_bracket_diameter = param("Tweeter bracket outer diameter", 104.25)
local tweeter_rear_chamfer = param("Tweeter rear cutout chamfer", 2)
local tweeter_center_y = param("Tweeter center Y", 318)
local tweeter_center_x = param("Tweeter center X", -60)

local half_width = outside_width / 2
local inner_half_width = half_width - wall_thickness
local inner_width = outside_width - 2 * wall_thickness
local inner_length = cabinet_length - 2 * wall_thickness
local inner_height = cabinet_height - 2 * wall_thickness

local outer_shell = translate(
	chamfer_all(box(outside_width, cabinet_length, cabinet_height), box_edge_chamfer),
	-half_width,
	0,
	0
)
local inner_cavity = translate(
	box(inner_width, inner_length, inner_height),
	-inner_width / 2,
	wall_thickness,
	wall_thickness
)
local cabinet = difference(outer_shell, inner_cavity)

-- The full-depth divider gives the midrange its own sealed chamber, preventing
-- woofer back-wave pressure from modulating the midrange cone.
local divider = translate(box(outside_width, divider_thickness, cabinet_height), -half_width, divider_y, 0)
cabinet = union(cabinet, divider)

-- A full-height brace couples the large long panels. Its pill-shaped window
-- keeps the woofer chamber acoustically continuous without sharp airflow edges.
local function woofer_window_brace()
	local overlap = 0.8
	local brace = translate(
		box(inner_width + 2 * overlap, woofer_brace_thickness, inner_height + 2 * overlap),
		-inner_half_width - overlap,
		woofer_brace_y,
		wall_thickness - overlap
	)
	local opening_depth = woofer_brace_thickness + 2
	local window_height = cabinet_height / 2
	local cap_offset = (woofer_brace_window_width - woofer_brace_window_height) / 2
	local center_window = translate(
		box(woofer_brace_window_width - woofer_brace_window_height, opening_depth, woofer_brace_window_height),
		-cap_offset,
		woofer_brace_y,
		window_height - woofer_brace_window_height / 2
	)
	local left_cap = rotate_x(cylinder(woofer_brace_window_height, opening_depth), 90)
	left_cap = translate(left_cap, -cap_offset, woofer_brace_y + opening_depth, window_height)
	local right_cap = translate(left_cap, 2 * cap_offset, 0, 0)
	return difference(brace, union(center_window, left_cap, right_cap))
end

cabinet = union(cabinet, woofer_window_brace())

local function top_face_cutter(diameter, inside_depth, outside_depth, center_x, center_y)
	return translate(
		cylinder(diameter, inside_depth + outside_depth),
		center_x,
		center_y,
		cabinet_height - inside_depth
	)
end

local function top_face_baffle(diameter, center_x, center_y)
	return translate(cylinder(diameter, baffle_thickness + 0.8), center_x, center_y, cabinet_height)
end

-- Shallow cosmetic rings overlap the baffle edge, leaving all driver mounting
-- surfaces and bolt locations unchanged.
local function baffle_trim_ring(baffle_diameter, center_x, center_y)
	local ring = translate(
		cylinder(baffle_diameter + 2 * trim_ring_width, trim_ring_height),
		center_x,
		center_y,
		cabinet_height + baffle_thickness
	)
	local inner_cut = translate(
		cylinder(baffle_diameter - 2 * trim_ring_overlap, trim_ring_height + 0.2),
		center_x,
		center_y,
		cabinet_height + baffle_thickness - 0.1
	)
	return ring, inner_cut
end

-- A 45 degree flare relieves the rear of a driver cutout without reducing the
-- flat top-face mounting land or intersecting the nearby bolt holes.
local function rear_cutout_flare(cutout_diameter, chamfer_depth, center_x, center_y)
	return translate(
		cone(cutout_diameter + 2 * chamfer_depth, cutout_diameter, chamfer_depth),
		center_x,
		center_y,
		cabinet_height - wall_thickness
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

-- Three low-relief rails on each long wall add visual structure and provide a
-- small amount of additional panel stiffness without crowding the wire exits.
local function side_ribs()
	local overlap = 0.8
	local rib_height = cabinet_height - 2 * side_rib_end_clearance
	local ribs = {}
	for _, y_fraction in ipairs({ 0.17, 0.50, 0.88 }) do
		local center_y = cabinet_length * y_fraction
		local right_rib = translate(
			box(side_rib_depth + overlap, side_rib_width, rib_height),
			half_width - overlap,
			center_y - side_rib_width / 2,
			side_rib_end_clearance
		)
		local left_rib = translate(
			box(side_rib_depth + overlap, side_rib_width, rib_height),
			-half_width - side_rib_depth,
			center_y - side_rib_width / 2,
			side_rib_end_clearance
		)
		table.insert(ribs, left_rib)
		table.insert(ribs, right_rib)
	end
	return ribs
end

-- Matching horizontal rails wrap the relief treatment around both end panels.
local function end_panel_ribs()
	local overlap = 0.8
	local rib_length = outside_width - 2 * side_rib_end_clearance
	local ribs = {}
	for _, z_fraction in ipairs({ 0.17, 0.50, 0.83 }) do
		local center_z = cabinet_height * z_fraction
		local front_rib = translate(
			box(rib_length, side_rib_depth + overlap, side_rib_width),
			-rib_length / 2,
			-side_rib_depth,
			center_z - side_rib_width / 2
		)
		local back_rib = translate(
			box(rib_length, side_rib_depth + overlap, side_rib_width),
			-rib_length / 2,
			cabinet_length - overlap,
			center_z - side_rib_width / 2
		)
		table.insert(ribs, front_rib)
		table.insert(ribs, back_rib)
	end
	return ribs
end

-- Rounded rails protect the four vertical corners and visually tie the
-- low-relief panel ribs together.
local function corner_bumpers()
	local radius = corner_bumper_diameter / 2
	local inset = radius - corner_bumper_projection
	local rail_height = cabinet_height - 2 * box_edge_chamfer
	local rails = {}
	for _, x_sign in ipairs({ -1, 1 }) do
		for _, y_center in ipairs({ inset, cabinet_length - inset }) do
			local rail = chamfer_all(cylinder(corner_bumper_diameter, rail_height), corner_bumper_chamfer)
			rail = translate(
				rail,
				x_sign * (half_width - inset),
				y_center,
				box_edge_chamfer
			)
			table.insert(rails, rail)
		end
	end
	return rails
end

-- Feet extend downward from the box bottom. Their open-bottom recesses hold
-- 0.25 in Sorbothane discs flush with the floor-contact surface.
local function isolation_foot(center_x, center_y)
	local foot = chamfer_all(cylinder(foot_diameter, foot_height + 0.8), foot_edge_chamfer)
	foot = translate(foot, center_x, center_y, -foot_height)
	local collar = translate(
		cone(foot_diameter, foot_diameter + 2 * foot_collar_flare, foot_collar_height + 0.2),
		center_x,
		center_y,
		-foot_collar_height
	)
	local recess = translate(
		cylinder(isolation_pad_diameter, isolation_pad_recess_depth + 0.2),
		center_x,
		center_y,
		-foot_height - 0.1
	)
	return union(foot, collar), recess
end

-- Two low-profile diagonal beams tie the foot collars together and brace the
-- broad bottom panel without extending below the Sorbothane contact surface.
local function bottom_cross_braces(foot_x, foot_y)
	local span_x = 2 * foot_x
	local span_y = cabinet_length - 2 * foot_y
	local diagonal_length = math.sqrt(span_x * span_x + span_y * span_y) + 2 * bottom_brace_foot_overlap
	local diagonal_angle = math.deg(math.atan(span_y, span_x))
	local center_y = cabinet_length / 2
	local brace = center_xy(box(diagonal_length, bottom_brace_width, bottom_brace_height))
	local forward_brace = translate(rotate_z(brace, diagonal_angle), 0, center_y, -bottom_brace_height)
	local reverse_brace = translate(rotate_z(brace, -diagonal_angle), 0, center_y, -bottom_brace_height)
	return { forward_brace, reverse_brace }
end

-- Snap a baffle of the given frame diameter flush against one side wall
-- (side = -1 or 1), then apply a manual offset. Used to auto-place the woofer
-- and midrange against opposite walls. The tweeter is positioned absolutely
-- instead, so it does not use this helper.
local function side_snapped_center_x(side, frame_diameter, center_x_offset)
	local baffle_radius = frame_diameter / 2 + baffle_margin
	return side * (half_width - baffle_radius - baffle_side_inset) + center_x_offset
end

-- Shared driver baffle builder. Every driver (woofer, midrange, tweeter) uses
-- the same construction: a raised baffle sized to the frame/bracket diameter,
-- a trim ring, a through-cutout smaller than the frame, and a rear relief flare.
-- Pass an empty bolt_angles table to defer bolt holes.
local function add_driver_cuts(cuts, baffles, trim_rings, trim_ring_cuts, center_x, center_y, frame_diameter, cutout_diameter, rear_chamfer, bolt_radius, bolt_hole_diameter, bolt_angles)
	local baffle_diameter = frame_diameter + 2 * baffle_margin
	local inside_depth = wall_thickness + 2
	local outside_depth = 20

	table.insert(
		baffles,
		top_face_baffle(
			baffle_diameter,
			center_x,
			center_y
		)
	)
	local trim_ring, trim_ring_cut = baffle_trim_ring(baffle_diameter, center_x, center_y)
	table.insert(trim_rings, trim_ring)
	table.insert(trim_ring_cuts, trim_ring_cut)

	table.insert(
		cuts,
		top_face_cutter(
			cutout_diameter,
			inside_depth,
			outside_depth,
			center_x,
			center_y
		)
	)
	table.insert(cuts, rear_cutout_flare(cutout_diameter, rear_chamfer, center_x, center_y))

	for _, angle_degrees in ipairs(bolt_angles) do
		local theta = math.rad(angle_degrees)
		local x_offset = bolt_radius * math.cos(theta)
		local y_offset = bolt_radius * math.sin(theta)
		table.insert(
			cuts,
			top_face_cutter(
				bolt_hole_diameter,
				inside_depth,
				outside_depth,
				center_x + x_offset,
				center_y + y_offset
			)
		)
	end
end

local cuts = {}
local baffles = {}
local trim_rings = {}
local trim_ring_cuts = {}
local ribs = side_ribs()
local end_ribs = end_panel_ribs()
local bumpers = corner_bumpers()
local feet = {}
local foot_recesses = {}
local foot_radius = foot_diameter / 2
local foot_x = half_width - foot_radius - foot_corner_inset
local foot_y = foot_radius + foot_corner_inset
local bottom_braces = bottom_cross_braces(foot_x, foot_y)
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

local midrange_bolt_angles = { 15.588362830481023, 464.411637169519, 135.58836283048103, 584.411637169519, 255.58836283048103, 344.411637169519 }

add_driver_cuts(
	cuts,
	baffles,
	trim_rings,
	trim_ring_cuts,
	side_snapped_center_x(-1, woofer_frame_diameter, woofer_x_offset),
	woofer_center_y,
	woofer_frame_diameter,
	woofer_cutout_diameter,
	woofer_rear_chamfer,
	woofer_bolt_radius,
	woofer_mount_hole_diameter,
	woofer_bolt_angles
)
add_driver_cuts(
	cuts,
	baffles,
	trim_rings,
	trim_ring_cuts,
	side_snapped_center_x(1, midrange_frame_diameter, midrange_x_offset),
	midrange_center_y,
	midrange_frame_diameter,
	midrange_cutout_diameter,
	midrange_rear_chamfer,
	midrange_bolt_radius,
	midrange_mount_hole_diameter,
	midrange_bolt_angles
)

-- The tweeter uses the same baffle builder as the other drivers. It is placed at
-- an absolute center_x (it does not snap to a side wall) and has no bolt holes yet.
-- Its through-cutout (85 mm) is smaller than its 104.25 mm mounting bracket, matching
-- the frame-vs-cutout relationship of the woofer and midrange.
add_driver_cuts(
	cuts,
	baffles,
	trim_rings,
	trim_ring_cuts,
	tweeter_center_x,
	tweeter_center_y,
	tweeter_bracket_diameter,
	tweeter_cutout_diameter,
	tweeter_rear_chamfer,
	0,
	0,
	{}
)

table.insert(cuts, wire_pass_through(woofer_center_y))
table.insert(cuts, wire_pass_through(midrange_center_y))

for _, trim_ring_cut in ipairs(trim_ring_cuts) do
	table.insert(cuts, trim_ring_cut)
end
for _, recess in ipairs(foot_recesses) do
	table.insert(cuts, recess)
end

cabinet = union(cabinet, table.unpack(feet))
cabinet = union(cabinet, table.unpack(baffles))
cabinet = union(cabinet, table.unpack(trim_rings))
cabinet = difference(cabinet, union(table.unpack(cuts)))

local wire_wall_face = wire_wall_side < 0 and "xmin" or "xmax"
local wire_hole_edges = edges(cabinet):on_box_side(wire_wall_face):geom("circle"):collect()
-- cabinet = chamfer(cabinet, wire_hole_edges, wire_hole_chamfer)
cabinet = union(cabinet, table.unpack(ribs))
cabinet = union(cabinet, table.unpack(end_ribs))
cabinet = union(cabinet, table.unpack(bumpers))
cabinet = union(cabinet, table.unpack(bottom_braces))
emit(cabinet)
