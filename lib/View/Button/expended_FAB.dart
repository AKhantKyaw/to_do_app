import 'package:flutter/material.dart';
import 'dart:math' as math;
class Threefloatingactionbuttton extends StatefulWidget {
  const Threefloatingactionbuttton(
      {Key? key,
      this.initialopen,
      required this.distance,
      required this.children})
      : super(key: key);
  final bool? initialopen;
  final double distance;
  final children;
  @override
  State<Threefloatingactionbuttton> createState() =>
      _ThreefloatingactionbutttonState();
}
class _ThreefloatingactionbutttonState extends State<Threefloatingactionbuttton>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> expendaimation;
  bool _open = false;
  @override
  void initState() {
    _open = widget.initialopen ?? false;
    controller = AnimationController(
      value: _open ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    expendaimation = CurvedAnimation(
        parent: controller,
        curve: Curves.bounceIn,
        reverseCurve: Curves.easeOutQuad);

    super.initState();
  }

  void dispose() {
    controller.dispose();
    super.dispose();
  }

  toggle() {
    setState(() {
      _open =! _open;
      if (_open) {
        controller.forward();
      } else {
        controller.reverse();
      }
    });
  }

  Widget buildTaptocloseFab() {
    return SizedBox(
      width: 56.0,
      height: 56.0,
      child: Center(
        child: Material(
          shape: const CircleBorder(),
          clipBehavior: Clip.antiAlias,
          elevation: 4.0,
          child: InkWell(
            onTap: toggle,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.close,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }

   buildExpandingActionButtons() {
    final children = <Widget>[];
    final count = widget.children.length;
    final step = 90.0 / (count - 1);
    for (var i = 0, angleInDegrees = 0.0;
        i < count;
        i++, angleInDegrees += step) {
      children.add(
        ExpandingActionButton(
          directionInDegrees: angleInDegrees,
          maxDistance: widget.distance,
          progress: expendaimation,
          child: widget.children[i],
        ),
      );
    }
    return children;
  }

   buildTapopenFab() {
    return IgnorePointer(
      ignoring: _open,
      child: AnimatedContainer(
        transformAlignment: Alignment.center,
        transform: Matrix4.diagonal3Values(
          _open ? 0.7 : 1.0,
          _open ? 0.7 : 1.0,
          1.0,
        ),
        duration: const Duration(milliseconds: 250),
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
        child: AnimatedOpacity(
          opacity: _open ? 0.0 : 1.0,
          curve: const Interval(0.25, 1.0, curve: Curves.easeInOut),
          duration: const Duration(milliseconds: 250),
          child: FloatingActionButton(
            backgroundColor: Colors.indigo,
            onPressed: toggle,
            child: const Icon(Icons.more_vert),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.bottomRight,
        clipBehavior: Clip.none,
        children: [
          buildTaptocloseFab(),
          ...buildExpandingActionButtons(),
          buildTapopenFab(),
        ],
      ),
    );
  }
}

class ExpandingActionButton extends StatelessWidget {
  const ExpandingActionButton(
      {Key? key,
      required this.child,
      required this.directionInDegrees,
      required this.maxDistance,
      required this.progress})
      : super(key: key);
  final double directionInDegrees;
  final double maxDistance;
  final Animation<double> progress;
  final Widget child;

  @override
   build(BuildContext context) {
    return AnimatedBuilder(
      animation: progress,
      builder: (context, child) {
        final offset = Offset.fromDirection(
          directionInDegrees * (math.pi /180.0),
          progress.value * maxDistance,
        );
        return Positioned(
          right: 4.0 + offset.dx,
          bottom: 4.0 + offset.dy,
          child: Transform.rotate(
            angle: (1.0 - progress.value) * math.pi / 2,
            child: child!,
          ),
        );
      },
      child: FadeTransition(
        opacity: progress,
        child: child,
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  const ActionButton({
    Key? key,
    this.onPressed,
    required this.icon,
    required this.color,
  });

  final VoidCallback? onPressed;
  final Widget icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color:Colors.teal,
      elevation: 4.0,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
        color: color,
      ),
    );
  }
}
