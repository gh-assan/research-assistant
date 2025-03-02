module WithRetry
  def with_retry(max_attempts: 3, wait_time: 0.1)
    attempts = 0
    begin
      attempts += 1
      yield
    rescue StandardError => e
      raise e if attempts >= max_attempts
      sleep(wait_time)
      retry
    end
  end
end