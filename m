Content-Type: multipart/mixed; boundary="===============4279352075465326669=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Quectel EC200T USB: Problems with context activation
Date: Wed, 30 Dec 2020 10:42:43 -0600
Message-ID: <aae395ab-8349-bce2-90f1-90630f08b946@gmail.com>
In-Reply-To: <CAFiQ674Dx2getC26fiCbeWLMSTfBkfWaE8voenvO+8YcJRJwPA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4279352075465326669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On 12/30/20 4:00 AM, Sergei Golubtsov wrote:
> Hello Denis,
> =

>  > Are the username and password set properly on the context?
> =

> Yes, they are.
> root(a)131D2F4C5254324B:~# /usr/lib/ofono/test/list-contexts
> [ /quectel_0 ]
>  =C2=A0 =C2=A0 [ /quectel_0/context1 ]
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Name =3D =D0=A0=D0=BE=D1=81=D1=81=D0=B8=D1=
=8F
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Active =3D 0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Type =3D internet
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Protocol =3D ip
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 AccessPointName =3D internet
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Username =3D gdata
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Password =3D gdata
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 AuthenticationMethod =3D pap
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Settings =3D { }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv6.Settings =3D { }
> =

>  =C2=A0 =C2=A0 [ /quectel_0/context2 ]
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Name =3D =D0=9C=D0=B5=D0=B3=D0=B0=D0=A4=D0=
=BE=D0=BD MMS
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Active =3D 0
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Type =3D mms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Protocol =3D ip
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 AccessPointName =3D mms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Username =3D mms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Password =3D mms
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 AuthenticationMethod =3D pap
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 MessageProxy =3D 10.10.10.10:8080 <http://10=
.10.10.10:8080>
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 MessageCenter =3D http://mmsc:8002
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 Settings =3D { }
>  =C2=A0 =C2=A0 =C2=A0 =C2=A0 IPv6.Settings =3D { }
> =


Looks fine...

>  > And you may want to share the log of oFono activating the context conf=
igured =

> for PAP.
> =

> I have added the PAP context activation log file from ofono to this=C2=A0=
email as =

> well as I did in the previous email. Please find it=C2=A0attached. It als=
o fails at =


It wasn't clear whether the previous log was pap or chap.  With chap the PP=
P =

implementation would stop and wait for the chap challenge.  So if that neve=
r =

comes, that would explain why you get stuck just after entering phase '2' -=
> =

PHASE_AUTHENTICATION

> the same phase: "gatppp.c:ppp_enter_phase() 2"
> Probably I need to try to dump the ppp connection and analyze it with Wir=
eShark. =

> Any ideas will be appreciated.

Never tried this myself, but I never really had a reason to.  Not sure if t=
here =

is an easy way of doing that given you're running over a MUX.  If you come =
up =

with a nice way, please share.

Maybe put a few debug statements in ppp_auth.c, ppp_pap_start, ppp_pap_time=
out =

and ppp_pap_process_packet.  See if PAP even occurs.

Regards,
-Denis
--===============4279352075465326669==--

