module MyModule::QuizBadges {

    use aptos_framework::signer;

    /// Resource to track a student's quiz badges and credits unlocked
    struct StudentProgress has key {
        badges: u64,
        credits_unlocked: bool,
    }

    /// Function to initialize progress for a student
    public fun register_student(account: &signer) {
        let progress = StudentProgress {
            badges: 0,
            credits_unlocked: false,
        };
        move_to(account, progress);
    }

    /// Function to add a quiz badge, and unlock credits if threshold is met
    public fun earn_badge(student: &signer, threshold: u64) acquires StudentProgress {
        let progress = borrow_global_mut<StudentProgress>(signer::address_of(student));
        progress.badges = progress.badges + 1;

        if (progress.badges >= threshold && !progress.credits_unlocked) {
            progress.credits_unlocked = true;
        }
    }
}
