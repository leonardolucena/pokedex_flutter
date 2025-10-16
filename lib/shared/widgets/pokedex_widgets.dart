import 'package:flutter/material.dart';
import '../themes/pokedex_theme.dart';

/// Widget de card personalizado do Pokedex
class PokedexCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final double? elevation;
  
  const PokedexCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.elevation,
  });
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Card(
        elevation: elevation ?? 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: PokedexTheme.primaryRed.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        color: backgroundColor ?? Theme.of(context).cardColor,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: padding ?? const EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  (backgroundColor ?? Theme.of(context).cardColor).withValues(alpha: 0.1),
                  (backgroundColor ?? Theme.of(context).cardColor),
                ],
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Widget de botão personalizado do Pokedex
class PokedexButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;
  final IconData? icon;
  final bool isLoading;
  
  const PokedexButton({
    super.key,
    required this.text,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.isLoading = false,
  });
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? PokedexTheme.primaryRed,
        foregroundColor: textColor ?? Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        elevation: 4,
      ),
      child: isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 20),
                  const SizedBox(width: 8),
                ],
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
    );
  }
}

/// Widget de chip personalizado para tipos de Pokemon
class PokemonTypeChip extends StatelessWidget {
  final String type;
  final bool isSelected;
  final VoidCallback? onTap;
  
  const PokemonTypeChip({
    super.key,
    required this.type,
    this.isSelected = false,
    this.onTap,
  });
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: _getTypeColor(type),
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? Border.all(color: Colors.white, width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: _getTypeColor(type).withValues(alpha: 0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          type.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
  
  Color _getTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'fire':
        return const Color(0xFFFF6B35);
      case 'water':
        return const Color(0xFF4A90E2);
      case 'grass':
        return const Color(0xFF7ED321);
      case 'electric':
        return const Color(0xFFFFD700);
      case 'psychic':
        return const Color(0xFF9013FE);
      case 'ice':
        return const Color(0xFF50E3C2);
      case 'dragon':
        return const Color(0xFF7B68EE);
      case 'dark':
        return const Color(0xFF4A4A4A);
      case 'fairy':
        return const Color(0xFFFF69B4);
      case 'normal':
        return const Color(0xFF9B9B9B);
      case 'fighting':
        return const Color(0xFFD0021B);
      case 'flying':
        return const Color(0xFF9013FE);
      case 'poison':
        return const Color(0xFFB8E986);
      case 'ground':
        return const Color(0xFFD2691E);
      case 'rock':
        return const Color(0xFF8B4513);
      case 'bug':
        return const Color(0xFF7ED321);
      case 'ghost':
        return const Color(0xFF9013FE);
      case 'steel':
        return const Color(0xFFC0C0C0);
      default:
        return PokedexTheme.primaryRed;
    }
  }
}

/// Widget de loading personalizado do Pokedex
class PokedexLoading extends StatelessWidget {
  final String? message;
  
  const PokedexLoading({
    super.key,
    this.message,
  });
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: PokedexTheme.primaryRed,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: PokedexTheme.primaryRed.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: 24),
            Text(
              message!,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: PokedexTheme.primaryRed,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
