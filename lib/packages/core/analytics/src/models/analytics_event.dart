class AnalyticsEvent {
  const AnalyticsEvent({
    required this.name,
    this.category,
    this.parameters = const {},
    this.timestamp,
  });

  final String name;

  final String? category;

  final Map<String, dynamic> parameters;

  final DateTime? timestamp;

  AnalyticsEvent copyWith({
    String? name,
    String? category,
    Map<String, dynamic>? parameters,
    DateTime? timestamp,
  }) {
    return AnalyticsEvent(
      name: name ?? this.name,
      category: category ?? this.category,
      parameters: parameters ?? this.parameters,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  String toString() {
    return 'AnalyticsEvent(name: $name, category: $category, parameters: $parameters)';
  }
}

