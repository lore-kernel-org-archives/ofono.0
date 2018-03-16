Content-Type: multipart/mixed; boundary="===============7444616186547069693=="
MIME-Version: 1.0
From: Gabriel Lucas <gabriel.lucas@smile.fr>
Subject: Re: [PATCH 3/6] gemalto: acquire the network technology
Date: Fri, 16 Mar 2018 13:04:27 +0100
Message-ID: <c84a86a2-9706-b42f-50c4-e9ea914cbd32@smile.fr>
In-Reply-To: <5ecb1ebc-55e5-6bca-5686-69a9deeebff1@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7444616186547069693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

Really sorry, this patch is from Mariem and I haven't reviewed it.

the cinterion_parse_tech function really needs to be rework. I'll resend you
a cleaner version today.

On 15/03/2018 18:19, Denis Kenzior wrote:
> Hi Gabriel,
>
> On 03/15/2018 07:49 AM, Gabriel Lucas wrote:
>> From: Mariem Cherif <mariem.cherif@ardia.com.tn>
>>
>> ---
>> =C2=A0 drivers/atmodem/network-registration.c | 45 =

>> ++++++++++++++++++++++++++++++++++
>> =C2=A0 1 file changed, 45 insertions(+)
>>
>> diff --git a/drivers/atmodem/network-registration.c =

>> b/drivers/atmodem/network-registration.c
>> index a5e2af3..aec9c2d 100644
>> --- a/drivers/atmodem/network-registration.c
>> +++ b/drivers/atmodem/network-registration.c
>> @@ -48,6 +48,7 @@ static const char *cops_prefix[] =3D { "+COPS:", NULL =
};
>> =C2=A0 static const char *csq_prefix[] =3D { "+CSQ:", NULL };
>> =C2=A0 static const char *cind_prefix[] =3D { "+CIND:", NULL };
>> =C2=A0 static const char *cmer_prefix[] =3D { "+CMER:", NULL };
>> +static const char *smoni_prefix[] =3D { "^SMONI:", "", NULL };
>
> Is there a reason why "" is added?=C2=A0 Is the modem sending lines not =

> prefixed by '^SMONI:' in the response?
>
>> =C2=A0 static const char *zpas_prefix[] =3D { "+ZPAS:", NULL };
>> =C2=A0 static const char *option_tech_prefix[] =3D { "_OCTI:", "_OUWCTI:=
", =

>> NULL };
>> =C2=A0 @@ -178,6 +179,32 @@ static int option_parse_tech(GAtResult *resu=
lt)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return tech;
>> =C2=A0 }
>> =C2=A0 +static int cinterion_parse_tech(GAtResult *result)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int tech =3D -1;
>> +=C2=A0=C2=A0=C2=A0 GAtResultIter iter;
>> +=C2=A0=C2=A0=C2=A0 GSList *l;
>
> new line here please
>
>> +=C2=A0=C2=A0=C2=A0 g_at_result_iter_init(&iter, result);
>> +=C2=A0=C2=A0=C2=A0 l =3D result->lines;
>
> What does the output look like?
>
>> +=C2=A0=C2=A0=C2=A0 if (strstr(l->data, "^SMONI: ") !=3D NULL) {
>
> Generally we use g_at_result_iter_next("^SMONI:");
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gchar **body =3D g_strsplit(=
l->data, "^SMONI: ", 2);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (*body !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gcha=
r **data =3D g_strsplit(body[1], ",", 20);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
*data !=3D NULL) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (g_strcmp0(data[0], "2G") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tech =3D ACCESS_TECHNOLOGY_GS=
M;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else if (g_strcmp0 (data[0], "3G") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tech =3D ACCESS_TECHNOLOGY_UT=
RAN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else if (g_strcmp0 (data[0], "4G") =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tech =3D ACCESS_TECHNOLOGY_EU=
TRAN;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> Are you leaking data?=C2=A0 Have you run this through valgrind?
>
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_st=
rfreev(body);
>
> It seems all of this can be accomplished with =

> g_at_result_iter_next_unquoted_string.
>
> Regards,
> -Denis


--===============7444616186547069693==--

