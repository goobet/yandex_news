RSpec.describe YandexUpdateJob do
  include ActiveJob::TestHelper

  subject(:job) { YandexUpdateJob.perform_later }

  describe '#perform_later' do
    it { expect { job }.to enqueue_job }

    it 'updates news' do
      expect_any_instance_of(NewsUpdater).to receive(:process)
      perform_enqueued_jobs { job }
    end
  end
end
