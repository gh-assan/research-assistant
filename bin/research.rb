def main
  # ... existing setup

  # Initialize Iteration Manager with all components
  iteration_manager = CoreEngine::IterationManager.new(
    api_client: api_client,
    file_manager: file_manager,
    question_engine: question_engine,
    progress_tracker: CoreEngine::ProgressTracker.new,
    depth_adjuster: CoreEngine::DepthAdjuster.new,
    focus_prioritizer: CoreEngine::FocusPrioritizer.new,
    termination_evaluator: CoreEngine::TerminationEvaluator.new,
    feedback_system: CoreEngine::FeedbackSystem.new
  )

  # Run research
  iteration_manager.run(analysis)
end