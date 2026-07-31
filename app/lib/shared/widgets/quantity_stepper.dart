import 'package:flutter/material.dart';
import '../../shared/utils/decimal_validator.dart';

class QuantityStepper extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;
  final double step;

  const QuantityStepper({
    super.key,
    this.initialValue = 1,
    required this.onChanged,
    this.min = 0.01,
    this.max = 99999.99,
    this.step = 1,
  });

  @override
  State<QuantityStepper> createState() => _QuantityStepperState();
}

class _QuantityStepperState extends State<QuantityStepper> {
  late TextEditingController _controller;
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
    _controller = TextEditingController(text: DecimalValidator.format(_value));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _update(double newValue) {
    final clamped = newValue.clamp(widget.min, widget.max);
    _value = double.parse(clamped.toStringAsFixed(2));
    _controller.text = DecimalValidator.format(_value);
    widget.onChanged(_value);
  }

  void _onFieldSubmitted(String val) {
    final parsed = double.tryParse(val);
    if (parsed != null) {
      _update(parsed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _StepperButton(
          icon: Icons.remove,
          onTap:
              _value > widget.min ? () => _update(_value - widget.step) : null,
        ),
        SizedBox(
          width: 80,
          child: TextField(
            controller: _controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            textAlign: TextAlign.center,
            onSubmitted: _onFieldSubmitted,
            decoration: const InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              border: InputBorder.none,
            ),
          ),
        ),
        _StepperButton(
          icon: Icons.add,
          onTap:
              _value < widget.max ? () => _update(_value + widget.step) : null,
        ),
      ],
    );
  }
}

class _StepperButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _StepperButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor:
            onTap != null
                ? const Color(0xFFF1F5F9)
                : const Color(0xFFF1F5F9).withValues(alpha: 0.5),
        minimumSize: const Size(40, 40),
        tapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }
}
