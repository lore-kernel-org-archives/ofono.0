Content-Type: multipart/mixed; boundary="===============4019871691626397899=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/4 v2] New rilmodem sms test
Date: Thu, 19 Nov 2015 16:43:52 -0600
Message-ID: <564E50A8.8020304@gmail.com>
In-Reply-To: <1447971691-22662-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4019871691626397899==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 11/19/2015 04:21 PM, Tony Espy wrote:
> This patch series adds a second rilmodem test for SMS.
> The common server test functions have been extracted
> for use by future rilmodem tests, and test-rilmodem-cs
> has been re-factored to use the common server code.
>
> Tony Espy (4):
>    unit: add new test-rilmodem-sms
>    build: add support for test-rilmodem-sms
>    unit: re-factor test-rilmodem-cs server logic
>    build: update for test-rilmodem-cs changes
>
>   Makefile.am                 |  26 ++-
>   unit/rilmodem-test-server.c | 196 +++++++++++++++++++++++
>   unit/rilmodem-test-server.h |  40 +++++
>   unit/test-rilmodem-cs.c     | 379 ++++++++++++++-----------------------=
-------
>   unit/test-rilmodem-sms.c    | 261 ++++++++++++++++++++++++++++++
>   5 files changed, 639 insertions(+), 263 deletions(-)
>   create mode 100644 unit/rilmodem-test-server.c
>   create mode 100644 unit/rilmodem-test-server.h
>   create mode 100644 unit/test-rilmodem-sms.c
>

Applied all of these after silently fixing up missing / extraneous '\' =

characters in patch 4.

Regards,
-Denis

--===============4019871691626397899==--

