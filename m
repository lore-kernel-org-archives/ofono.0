Content-Type: multipart/mixed; boundary="===============6112103737473746048=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/2] Fix rilmodem SMSC quoting
Date: Fri, 04 Dec 2015 16:25:44 -0600
Message-ID: <566212E8.8060204@gmail.com>
In-Reply-To: <1449263818-14263-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6112103737473746048==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 12/04/2015 03:16 PM, Tony Espy wrote:
> This changeset fixes the string formatting of the
> RIL_REQUEST_SET_SMSC_ADDRESS request, which requires
> the string to bracketed by quotation marks.
>
> Tony Espy (2):
>    rilmodem: restore SET_SMSC_ADDRESS number format
>    unit: update test-rilmodem-sms set_sca test case
>
>   drivers/rilmodem/sms.c   | 4 +++-
>   unit/test-rilmodem-sms.c | 8 ++++----
>   2 files changed, 7 insertions(+), 5 deletions(-)
>

Both applied, thanks.

Regards,
-Denis

--===============6112103737473746048==--

