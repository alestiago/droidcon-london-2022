import 'package:flame/components.dart';
import 'package:flame_forge2d/body_component.dart';

class GravitatingBehavior extends Component with ParentIsA<BodyComponent> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    parent.body.gravityOverride = Vector2.zero();
    parent.body.linearDamping = 10;
  }

  @override
  void update(double dt) {
    super.update(dt);
    final center = parent.gameRef.size / 2;
    parent.body.gravityOverride!.setValues(
      center.x - parent.body.position.x,
      center.y - parent.body.position.y,
    );
  }
}
