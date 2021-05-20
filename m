Content-Type: multipart/mixed; boundary="===============5080563997691200306=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Thu, 20 May 2021 12:57:56 -0500
Message-ID: <4f8b7f2e-f3bb-1415-eb3b-b9b02390076a@gmail.com>
In-Reply-To: <CAFiQ674a-ymNTC-WhJrC98kR+BXe2nCcuCzAdsDDo+TnBQp5YA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5080563997691200306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 5/19/21 6:35 PM, Sergei Golubtsov wrote:
> Hi Denis,
> =

> Thank you very much for your quick and helpful reply.
> =

> The problem is a bit vulgar actually. That's a shame that I took your
> time for that but I have another question as I am not sure about the
> findings below.

no worries.

> =

> I had tried to get dump with gsmdial and gsmdial successfully
> activated the context. So the problem is that we have authentication
> method set to NONE in ofono. But gsmdial uses CHAP by default.
> I have manually set the auth to CHAP for the context in ofono and
> ofono successfully activated the context.

Yes, oFono used to use CHAP by default, but this was changed a few years ag=
o.

> There is the provider info from mobile-broadband-provider-info about
> my provider:
> =

>      <provider>
>      <name>China Unicom</name>
>      <gsm>
>      <network-id mcc=3D"460" mnc=3D"01"/>
>      <apn value=3D"3gnet">
>      <plan type=3D"postpaid"/>
>      <usage type=3D"internet"/>
>      <username>uninet</username>
>      </apn>
>      <apn value=3D"3gwap">
>      <usage type=3D"mms"/>
>      <name>=E8=81=94=E9=80=9A=E5=BD=A9=E4=BF=A1</name>
>      <mmsc>http://mmsc.myuni.com.cn</mmsc>
>      <mmsproxy>10.0.0.172:80</mmsproxy>
>      </apn>
>      </gsm>
>      </provider>
> =

> =

> Am I correct that ofono must use CHAP if the auth method is not
> specified in the db?

We used to do this, then around Sep-Oct 2018 there was a strong push to add=
 an =

explicit 'No Authentication' option for oFono from one of the modem hardwar=
e =

vendors.  I don't recall the exact arguments, search the archives, but the =

fallout was that an empty username / password implied no authentication.  W=
hich =

I think does make a certain amount of sense.

git show 6cf24fe1f9cfa2a61422ad84abfdd32e7ea2cf78.  Look around at the comm=
its =

from the same author.  I do seem to recall that 3GPP mandated CHAP to be us=
ed as =

the default, even in the no username / password case.  But my memory is fuz=
zy =

now, and there hasn't been any problems reported since then (until now).

> =

> I see that the technology used by the modem is HSPA. And I see the
> following in ofono/drivers/atmodem/lte.c:
> =

>      /* change the authentication method if the  parameters are invalid */
>      if (!*ldd->pending_info.username || !*ldd->pending_info.password)
>         auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> =

> =

> And in ofono/plugins/mbpi.c:
> =

>      /* select authentication method NONE if fit */
>      if (!ap->username || !ap->password)
>      ap->auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> =

> =

> As well as ofono/plugins/fileprovision.c::
> =

>      /* select default authentication method */
>      (*settings)[0].auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> =

> =

> ofono/src/lte.c:
> =

>      /* this must have a valid default */
>     if (!gprs_auth_method_from_string(auth_method_str,
>     &lte->info.auth_method))
>     lte->info.auth_method =3D OFONO_GPRS_AUTH_METHOD_NONE;
> =

> =

> I am not sure about the standards which may be relevant here. Sorry
> for asking this but I thought that we should use CHAP by default,
> don't we?

The question is really whether it is the network or the modem at fault here=
. =

Does AUTH_METHOD_NONE work on other networks with this hardware?

> =

> Thank you again and have a nice day.
> =

> Yours sincerely,
> Sergei Golubtsov.
> =


Regards,
-Denis
--===============5080563997691200306==--

