Content-Type: multipart/mixed; boundary="===============1906757311734958261=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: [PATCH v3] ifx: Adding modem selftest for Infineon modem
Date: Thu, 06 Jan 2011 14:18:46 -0800
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A52CE50@orsmsx508.amr.corp.intel.com>
In-Reply-To: <1294264068.2521.12.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1906757311734958261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> >  plugins/ifx.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++=
-------
> >  1 files changed, 66 insertions(+), 10 deletions(-)
> > =

> > diff --git a/plugins/ifx.c b/plugins/ifx.c
> > index c0a69c2..e0eb982 100644
> > --- a/plugins/ifx.c
> > +++ b/plugins/ifx.c
> > @@ -71,6 +71,8 @@
> >  #define GPRS3_DLC   4
> >  #define AUX_DLC     5
> >  =

> > +#define IFX_SELF_TESTS_TIMEOUT	10
> > +
> =

> I asked this 3 times now, where is this magic value of 10 seconds coming
> from. What is the average expected execution time of each test?

Typical response times are much less than 0.5 sec. 10 seconds is considered
much longer than any normal response time. =


> > +static struct {
> > +	char *test_desc;
> > +	char *at_cmd;
> > +} const mst[] =3D {
> > +	{ "AT Command Test", "ATE0 +CMEE=3D1" }, /* set echo & error reportin=
g */
>
> I really don't like to put ATE0 into this. It is not a selftest or test
> command.

It acts as a selftest command because if the modem fails to come out of res=
et
and/or start the AT command parser you will never get an OK back on it. In =
the =

error reporting we would like to be able to distinguish between the AT comm=
and
parser not working at all and any subsequent test command failing.

> > +	{ "RTC GTI Test", "at(a)rtc:rtc_gti_test_verify_32khz()" },
> > +	{ "Device Version Test", "at(a)vers:device_version_id()" },
> > +	{ NULL, NULL }
> > +};
>
> And I like to still see an answer why we have to trigger selftests here.

To make sure the modem is properly functioning.

> Can we just not have one AT command to check the modem health and be
> done with it?

The IFX modem we are targetting implements this with two AT commands.

> Another question that I did ask is to see some sample results from these
> test cases in failure and success case.

Robertino?

> Do we actually care about test
> description here at all or can we just drop it?

If you prefer cryptic messages then the AT command itself can act as the de=
scription.
Is that preferred?

> This is rather pointless. We are not starting a timeout for every single
> command. The mux_timeout handling was designed for spawning the overall
> setup process and not just one command.

The design documentation wasn't clear on that point. The name mux_timeout
suggested that the timeout only applied to the mux, maybe it should be rena=
med to
setup_timeout to better describe the design intention?

Regardless, having a timeout for each command is conceptually cleaner as yo=
u will
know for sure which command is responsible for exceeding the timeout. =


Does oFono require the more ambiguous solution with a single timeout?

> I am fine with using the established mutliplexer timeout handling here,
> but essentially this is not a SELF_TESTS timeout. This is overall setup
> timeout. So can we please get the naming right here. I really dislike
> code where function names and constants are not named properly. This
> causes major confusion later on.

In the patch it is the timeout for the first self test command.
I understand you are thinking about a potential future patch in which it wo=
uld be
used as the overall setup timeout, I agree that in that case the name shoul=
d be
changed accordingly as well, yes.

Cheers,
Waldo


--===============1906757311734958261==--

