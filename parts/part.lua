-- Sealed two-way prototype speaker enclosure.
-- X = cabinet width, Y = cabinet length, Z = height.

local inch = 25.4

-- Cabinet geometry. The 410 mm length keeps this one-piece model within the
-- stated 420 x 420 x 480 mm printer build volume.
local outside_width = param("Outside width", 9.5 * inch)
local cabinet_length = param("Cabinet length", 410)
local wall_thickness = param("Wall thickness", 8)
local cabinet_height = param("Cabinet height", 220)
local divider_y = param("Woofer chamber length", 270)
local divider_thickness = param("Divider thickness", 8)
local woofer_brace_y = param("Woofer window brace Y", 245)
local woofer_brace_thickness = param("Woofer window brace thickness", 8)
local woofer_brace_window_width = param("Woofer brace window width", 160)
local woofer_brace_window_height = param("Woofer brace window height", 90)
local baffle_thickness = param("Raised baffle thickness", 12)
local baffle_margin = param("Raised baffle margin", 6)
local baffle_side_inset = param("Raised baffle side inset", 2)

-- Check these against the supplied manufacturer CAD before printing.
local woofer_cutout_diameter = param("Woofer cutout diameter", 194.1)
local woofer_frame_diameter = param("Woofer frame diameter", 222)
local woofer_bolt_radius = param("Woofer bolt radius", 105)
local woofer_mount_hole_diameter = param("Woofer mount hole diameter", 5.2)
local woofer_center_y = param("Woofer center Y", 140)
local woofer_x_offset = param("Woofer X offset", 2)

local midrange_cutout_diameter = param("Midrange cutout diameter", 101)
local midrange_frame_diameter = param("Midrange frame diameter", 120)
local midrange_bolt_radius = param("Midrange bolt radius", 55.8)
local midrange_mount_hole_diameter = param("Midrange mount hole diameter", 4.5)
local midrange_center_y = param("Midrange center Y", 340)
local midrange_x_offset = param("Midrange X offset", -2)
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
	local cutter_z = cabinet_height - emblem_engraving_depth
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

local function add_driver_cuts(cuts, baffles, side, center_y, center_x_offset, frame_diameter, cutout_diameter, bolt_radius, bolt_hole_diameter, bolt_angles)
	local baffle_radius = frame_diameter / 2 + baffle_margin
	local center_x = side * (half_width - baffle_radius - baffle_side_inset) + center_x_offset
	local inside_depth = wall_thickness + 2
	local outside_depth = 20

	table.insert(
		baffles,
		top_face_baffle(
			frame_diameter + 2 * baffle_margin,
			center_x,
			center_y
		)
	)

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
	woofer_x_offset,
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
	midrange_x_offset,
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
