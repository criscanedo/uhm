#include <time.h>
#include <unistd.h>
#include <err.h>
#include <sys/stat.h>
#include <sys/wait.h>

static char *mbox = "/var/mail/user";
static char *aud = "/mnt/aud/sounds/mail.wav";

static void play(void)
{
    char *cmd[] = { "aucat", "-i", aud, NULL };

    if (fork() == 0) {
        execvp(cmd[0], cmd);
        err(1, "execvp");
    }
    wait(NULL);
}

int main(void)
{
    struct stat st1, st2;
    struct timespec delay = { 0, 50000000 };

    if (access(mbox, F_OK) == -1)
        err(1, "%s", mbox);
    if (access(aud, F_OK) == -1)
        err(1, "%s", aud);

    if (stat(mbox, &st1) == -1)
        err(1, "%s", mbox);
    if (st1.st_size > 0)
        play();

    for (;;) {
        if (stat(mbox, &st2) == -1)
            err(1, "%s", mbox);
        if (st2.st_size > st1.st_size)
            play();
        st1 = st2;
        nanosleep(&delay, NULL);
    }
    return 0;
}
