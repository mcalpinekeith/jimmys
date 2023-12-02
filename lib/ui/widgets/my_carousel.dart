import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassy/glassy_card.dart';
import 'package:jimmys/ui/theme/constants.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({
    Key? key,
    required this.children,
    required this.onSelected,
  }) : super(key: key);

  final List<Widget> children;
  final Function(int) onSelected;

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final _controller = CarouselController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.sizeOf(context).width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(spacingMicro),
          child: GlassyCard(
            child: Row(
              children: [
                IconButton(
                  iconSize: iconLarge,
                  icon: const FaIcon(FontAwesomeIcons.circleLeft),
                  onPressed: () async => await _controller.previousPage(),
                ),
                Expanded(
                  child: Center(
                    child: AnimatedSmoothIndicator(
                      activeIndex: _selectedIndex,
                      count: widget.children.length,
                      onDotClicked: (index) => _controller.animateToPage(index),
                      effect: ExpandingDotsEffect(
                        spacing: spacingSmall,
                        activeDotColor: theme.colorScheme.primary,
                        dotColor: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  iconSize: iconLarge,
                  icon: const FaIcon(FontAwesomeIcons.circleRight),
                  onPressed: () async => await _controller.nextPage(),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            width: width,
            child: CarouselSlider.builder(
              carouselController: _controller,
              itemBuilder: (context, index, realIndex) => widget.children[index],
              itemCount: widget.children.length,
              options: CarouselOptions(
                padEnds: false,
                disableCenter: true,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  widget.onSelected(index);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}