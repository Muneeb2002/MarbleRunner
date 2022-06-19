import 'package:marblerunner/gameFiles/Wall.dart';

import 'main.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';

class Player extends CircleComponent with CollisionCallbacks {
  Player() {
    radius = 1333.333 / 44.44443333;
    position = Vector2(ballGame.gridCellSize*ballGame.gridSize - ballGame.gridCellSize / 2,
      ballGame.gridCellSize * ballGame.gridSize - ballGame.gridCellSize/2);
    // position = Vector2(0,0);
    anchor = Anchor.center;
    this.paint = BasicPalette.black.paint()..style = PaintingStyle.fill;
    add(CircleHitbox());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Wall) {
      Vector2 posDiff = Vector2((intersectionPoints.first.x - position.x).abs(),
          (intersectionPoints.first.y - position.y).abs());
      if (position.x < intersectionPoints.first.x && posDiff[0] > posDiff[1]) {
        // right
        // backlash = Vector2(-1, 0);
        ballGame.stopmovingRight = true;
      }
      if (position.x > intersectionPoints.first.x && posDiff[0] > posDiff[1]) {
        // left
        // backlash = Vector2(1, 0);
        ballGame.stopmovingLeft = true;
      }
      if (position.y > intersectionPoints.first.y && posDiff[0] < posDiff[1]) {
        //up
        // backlash = Vector2(0, 1);
        ballGame.stopmovingUp = true;
      }
      if (position.y < intersectionPoints.first.y && posDiff[0] < posDiff[1]) {
        //down
        // backlash = Vector2(0, -1);
        ballGame.stopmovingDown = true;
      }
    }
  }

  void onCollisionEnd(PositionComponent other) {
    ballGame.stopmovingRight = false;
    ballGame.stopmovingLeft = false;
    ballGame.stopmovingUp = false;
    ballGame.stopmovingDown = false;
  }
}
