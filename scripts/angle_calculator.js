/**
 * Calculates the angle P1-P2-P3, with P2 as the vertex.
 *
 * @param {{ x: number, y: number }} point1
 * @param {{ x: number, y: number }} point2
 * @param {{ x: number, y: number }} point3
 * @returns {number} Angle in degrees, from 0 to 180.
 */
function angleBetweenThreePoints(point1, point2, point3) {
  // Vectors extending outward from point 2
  const vector1 = {
    x: point1.x - point2.x,
    y: point1.y - point2.y,
  };

  const vector2 = {
    x: point3.x - point2.x,
    y: point3.y - point2.y,
  };

  const length1 = Math.hypot(vector1.x, vector1.y);
  const length2 = Math.hypot(vector2.x, vector2.y);

  // An angle is undefined if point 1 or point 3 overlaps point 2.
  if (length1 === 0 || length2 === 0) {
    throw new Error("Point 1 and point 3 must be different from point 2.");
  }

  const dotProduct = vector1.x * vector2.x + vector1.y * vector2.y;

  const crossProduct = vector1.x * vector2.y - vector1.y * vector2.x;

  // atan2 is more numerically stable than acos for this calculation.
  const angleRadians = Math.atan2(Math.abs(crossProduct), dotProduct);

  return angleRadians * (180 / Math.PI);
}

// Example:
// const point1 = { x: 486.407, y: 101.239 };
// const point2 = { x: 500.3, y: 155.302 };
// const point3 = { x: 460.426, y: 116.239 };

const point1 = { x: 284.26859238, y: 94.22835938 };
const point2 = { x: 315, y: 60 };
const point3 = { x: 300.72307506, y: 103.72835938 };

const angle = angleBetweenThreePoints(point1, point2, point3);

// console.log(angle); // 90

const drill_hole_1_angle = 0;
const drill_hole_2_angle = angle;
const drill_hole_3_angle = drill_hole_1_angle + 120;
const drill_hole_4_angle = drill_hole_2_angle + 120;
const drill_hole_5_angle = drill_hole_3_angle + 120;
const drill_hole_6_angle = drill_hole_4_angle + 120;

console.log(
  `${drill_hole_1_angle}, ${drill_hole_2_angle}, ${drill_hole_3_angle}, ${drill_hole_4_angle}, ${drill_hole_5_angle}, ${drill_hole_6_angle}`,
);
