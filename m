Content-Type: multipart/mixed; boundary="===============4889886595771506556=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/2] atmodem/atutil: at_util_gprs_proto_to_pdp_type
Date: Tue, 23 Oct 2018 05:01:14 +0200
Message-ID: <CAKSBH7HSp4WM_m5qYcyyNsa0uVE7SkES2yk1mLQHRg2KdbeOdw@mail.gmail.com>
In-Reply-To: <3bc03dbb-985d-1250-86ee-2bdd9478489d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4889886595771506556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Oct 22, 2018 at 10:04 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/22/2018 01:56 PM, Giacinto Cifelli wrote:
> > This function converts the ofono enum ofono_gprs_auth_method
> > into the value of the 3GPP 27.007 to pass to the AT command
> > ---
> >   drivers/atmodem/atutil.c | 16 ++++++++++++++++
> >   drivers/atmodem/atutil.h |  3 +++
> >   2 files changed, 19 insertions(+)
> >
>
> Your commit header does not match the patch contents or description.
> You might want to slow down a bit.

yes, I noticed that too late. Thank you for taking it anyway.

>
> Anyway, I renamed this to at_util_gprs_auth_method_to_auth_proto to
> match 3GPP naming & the naming of the pdp_type conversion function in
> the next patch.  And fixed up the commit description / header.
>
> Applied, thanks.
>
> Regards,
> -Denis

Regards,
Giacinto

--===============4889886595771506556==--

