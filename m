Content-Type: multipart/mixed; boundary="===============8907628500176658226=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH v2 1/4] sms_util: status_report_expiration
Date: Fri, 10 Sep 2010 10:49:55 -0500
Message-ID: <4C8A53A3.7000001@gmail.com>
In-Reply-To: <1284128902-16727-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8907628500176658226==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 09/10/2010 09:28 AM, Petteri Tikander wrote:
> ---
>  src/smsutil.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  src/smsutil.h |    3 +--
>  2 files changed, 49 insertions(+), 5 deletions(-)

All four patches have been applied.  Thanks :)

The only thing pending on this part is to handle the Status Report
recipient address being 'tweaked' by the network.

I've been hearing reports that some networks actually rewrite the
address (e.g. change national number to international, etc) which causes
our status reports to not match.

We can do two things:
1. Rely on message reference only.  This seems dangerous
2. Fallback to a 'fuzzy'.  E.g. try to match on the reference and last n
digits of the phone number, ignoring ton/npi.  This can get tricky as
some national numbers can get different prefixes from the equivalent
international number, so we need to pick a nice value of 'n'.

E.g. in Australia:

+61 4 1234 5678 is the international number or:
04 1234 5678 is the national number.

Let me know if you can think of a third option.

Regards,
-Denis

--===============8907628500176658226==--

