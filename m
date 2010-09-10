Content-Type: multipart/mixed; boundary="===============9193684546882583516=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: Re: [RFC PATCH v2 1/4] sms_util: status_report_expiration
Date: Fri, 10 Sep 2010 20:39:02 +0300
Message-ID: <201009102039.02324.petteri.tikander@ixonos.com>
In-Reply-To: <4C8A53A3.7000001@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9193684546882583516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Hi Petteri,
> =

> On 09/10/2010 09:28 AM, Petteri Tikander wrote:
> > ---
> >  src/smsutil.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++-=
--
> >  src/smsutil.h |    3 +--
> >  2 files changed, 49 insertions(+), 5 deletions(-)
> =

> All four patches have been applied.  Thanks :)

Thanks for you for assistance!

> =

> The only thing pending on this part is to handle the Status Report
> recipient address being 'tweaked' by the network.
> =

> I've been hearing reports that some networks actually rewrite the
> address (e.g. change national number to international, etc) which causes
> our status reports to not match.
> =

> We can do two things:
> 1. Rely on message reference only.  This seems dangerous
> 2. Fallback to a 'fuzzy'.  E.g. try to match on the reference and last n
> digits of the phone number, ignoring ton/npi.  This can get tricky as
> some national numbers can get different prefixes from the equivalent
> international number, so we need to pick a nice value of 'n'.
> =


Perhaps we can pick 'n' for number from the original number, in which SMS-
message was submitted:

      04 1234 5678 is the national number

Then we must remember to drop the first digit from the area code (or operat=
or =

code or what ever it's called): 04=3D> 4 =


So the number-string to be compared in the status report-response will be '=
4 =

1234 5678'

And after receiving status report in the international format just find =

correspondence with the international number (+61 4 1234 5678); last digits =

should match.

OK. I don't know (at least haven't heart), will some operators drop more th=
an =

one digit from the area code. This would cause problems anyway, when checki=
ng =

number-correspondence. But, I believe, number-checking presented above is =

better than nothing for 'national->international'-situation. =



> E.g. in Australia:
> =

> +61 4 1234 5678 is the international number or:
> 04 1234 5678 is the national number.
> =

> Let me know if you can think of a third option.
> =

> Regards,
> -Denis
> =


Have a nice week end.

Br, Petteri


--===============9193684546882583516==--

