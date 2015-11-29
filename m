Content-Type: multipart/mixed; boundary="===============8245204602571543776=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Add new rilmodem SMS test cases
Date: Sun, 29 Nov 2015 15:49:47 -0600
Message-ID: <565B72FB.3060407@gmail.com>
In-Reply-To: <1448393932-16043-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8245204602571543776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 11/24/2015 01:38 PM, Tony Espy wrote:
> This patchset adds new rilmodem SMS test cases, including
> tests for incoming SMS unsolicited responses.
>
> Tony Espy (2):
>    unit: add write support to rilmodem-test-server
>    unit: add new test-rilmodem-sms test cases
>
>   unit/rilmodem-test-server.c | 113 ++++++++------
>   unit/rilmodem-test-server.h |  11 +-
>   unit/test-rilmodem-cs.c     |   6 +-
>   unit/test-rilmodem-sms.c    | 356 +++++++++++++++++++++++++++++++++++++=
+++++--
>   4 files changed, 426 insertions(+), 60 deletions(-)
>

Both applied, thanks.

Regards,
-Denis

--===============8245204602571543776==--

