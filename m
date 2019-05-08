Content-Type: multipart/mixed; boundary="===============2417216339644562809=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Wed, 08 May 2019 09:37:14 -0500
Message-ID: <d87fb647-af8c-cb0c-2462-aba49d45533c@gmail.com>
In-Reply-To: <CAHB-Pj=9Tt08vYyLDEa46JeF5SyXvjCUphJ9U3ckV1+k=G5_pw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2417216339644562809==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 05/04/2019 02:06 PM, Richard R=C3=B6jfors wrote:
> Hi,
> =

> Den m=C3=A5n 22 apr. 2019 kl 09:44 skrev Jonas Bonn <jonas@norrbonn.se>:
>> +
>> +static void creg_notify(GAtResult *result, gpointer user_data)
>> +{
>> +       struct ofono_netreg *netreg =3D user_data;
>> +       int status, lac, ci, tech;
>> +       struct netreg_data *nd =3D ofono_netreg_get_data(netreg);
>> +       struct tech_query *tq;
>> +
>> +       if (at_util_parse_reg_unsolicited(result, "+CREG:", &status,
>> +                               &lac, &ci, &tech, nd->vendor) =3D=3D FAL=
SE)
>> +               return;
>> +
>> +       if (status !=3D 1 && status !=3D 5)
>> +               goto notify;
> =

> Just wants to check your thoughts about CREG and LTE only...
> If the modem only has 4g coverage it might set the status to 4 (unknown),
> but ureg would indicate LTE(7).
> I have done a local patch for this in gprs, do not go to de-attached
> state in that case.

It seems a bunch of devices have this problem.  By my reading of 27.007, =

CREG should not report status 4 unless there is no coverage whatsoever, =

e.g.:

"4	unknown (e.g. out of GERAN/UTRAN/E-UTRAN coverage)"

> =

> Just wondering if we should combine the CREG and UREG status
> in some way, the problem is that UREG is not indicating roaming or not...

So that sounds like a bug in the firmware.  Does ublox support +CEREG?

Regards,
-Denis

--===============2417216339644562809==--

