Content-Type: multipart/mixed; boundary="===============8208661485649119019=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH v3] ifx: Adding modem selftest for Infineon modem
Date: Tue, 11 Jan 2011 22:27:33 -0800
Message-ID: <1294813653.3873.62.camel@aeonflux>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C9015A52CE50@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8208661485649119019==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> > I asked this 3 times now, where is this magic value of 10 seconds coming
> > from. What is the average expected execution time of each test?
> =

> Typical response times are much less than 0.5 sec. 10 seconds is consider=
ed
> much longer than any normal response time. =


that was the answer what I was looking for. Thanks.

> > > +static struct {
> > > +	char *test_desc;
> > > +	char *at_cmd;
> > > +} const mst[] =3D {
> > > +	{ "AT Command Test", "ATE0 +CMEE=3D1" }, /* set echo & error report=
ing */
> >
> > I really don't like to put ATE0 into this. It is not a selftest or test
> > command.
> =

> It acts as a selftest command because if the modem fails to come out of r=
eset
> and/or start the AT command parser you will never get an OK back on it. I=
n the =

> error reporting we would like to be able to distinguish between the AT co=
mmand
> parser not working at all and any subsequent test command failing.

since we don't report any of these errors other than the logs this not
really helping you. I'd rather have the failing AT command in the log
than some text reference that you have to track down with the source
code to figure out what it means.

> > > +	{ "RTC GTI Test", "at(a)rtc:rtc_gti_test_verify_32khz()" },
> > > +	{ "Device Version Test", "at(a)vers:device_version_id()" },
> > > +	{ NULL, NULL }
> > > +};
> >
> > And I like to still see an answer why we have to trigger selftests here.
> =

> To make sure the modem is properly functioning.
> =

> > Can we just not have one AT command to check the modem health and be
> > done with it?
> =

> The IFX modem we are targetting implements this with two AT commands.

And that could have been changed to one command just giving a proper
result status on the modem health. That would have made sense to me.
Instead we are using some random commands to do this.

> > Another question that I did ask is to see some sample results from these
> > test cases in failure and success case.
> =

> Robertino?
> =

> > Do we actually care about test
> > description here at all or can we just drop it?
> =

> If you prefer cryptic messages then the AT command itself can act as the =
description.
> Is that preferred?

It is all cryptic at this point. As I said, a proper AT command to get
the result of the selftest sequence with proper result, that would be
not cryptic. This whole effort in trying to do selftest this way is not
how I would have this done.

> > This is rather pointless. We are not starting a timeout for every single
> > command. The mux_timeout handling was designed for spawning the overall
> > setup process and not just one command.
> =

> The design documentation wasn't clear on that point. The name mux_timeout
> suggested that the timeout only applied to the mux, maybe it should be re=
named to
> setup_timeout to better describe the design intention?
> =

> Regardless, having a timeout for each command is conceptually cleaner as =
you will
> know for sure which command is responsible for exceeding the timeout. =

> =

> Does oFono require the more ambiguous solution with a single timeout?

oFono does not require this, but it is also not helping you. If I read
your response right, then the selftest execution time is less than a
second anyway and thus it will return with either an error or with OK.
So the timeout comes from a modem not responding and that makes really
no difference with command causes this.

That's why I asked where these magic timeout values came from. I needed
to understand what are possible implications.

So with this in mind, just using the global mux setup timeout like we do
right now is fine. Individual timeouts are not buying you anything
additional.

> > I am fine with using the established mutliplexer timeout handling here,
> > but essentially this is not a SELF_TESTS timeout. This is overall setup
> > timeout. So can we please get the naming right here. I really dislike
> > code where function names and constants are not named properly. This
> > causes major confusion later on.
> =

> In the patch it is the timeout for the first self test command.
> I understand you are thinking about a potential future patch in which it =
would be
> used as the overall setup timeout, I agree that in that case the name sho=
uld be
> changed accordingly as well, yes.

Yep, that is how I want this done. It is way cleaner and since we don't
get any useful information out of the selftest anyway, that is good
enough.

Robertino, also the array of commands is rather pointless here. You can
just use g_at_chat_send in a row and have the callbacks you cancel all
remaining commands. That way the code becomes even more cleaner and we
don't have to bother with maintaining a command array.

Leave the ATE0.. command as it is. The only way that one fails if we run
into a timeout. And that works fine right now. So that is good enough.

Regards

Marcel



--===============8208661485649119019==--

