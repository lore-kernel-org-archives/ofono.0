Content-Type: multipart/mixed; boundary="===============5743868421185616438=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2 v3] unit: add new test rilmodem-cs
Date: Thu, 05 Nov 2015 14:51:05 -0600
Message-ID: <563BC139.8030107@gmail.com>
In-Reply-To: <1446755892-3370-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5743868421185616438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 11/05/2015 02:38 PM, Tony Espy wrote:
> This commit adds a new style of build-time/unit test to
> rilmodem.  These tests setup a dummy server socket and
> attach a gril instance to it.  This allows rilmodem
> call-settings atom functions to be tested directly,
> validating request parcels received by the server-side,
> and callbacks that happen in response to canned responses
> sent by the server-side.
> ---
>   unit/test-rilmodem-cs.c | 694 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 694 insertions(+)
>   create mode 100644 unit/test-rilmodem-cs.c
>

Both applied, thanks.

Regards,
-Denis


--===============5743868421185616438==--

