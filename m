Content-Type: multipart/mixed; boundary="===============9201612807214134748=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/1] gisi: Updated subscriptions and pipe handling to
 accomodate additional isimodem versions
Date: Fri, 04 Feb 2011 10:41:42 +0200
Message-ID: <AANLkTinWrKLgWUTgcTPEKObc8bp2qBrmD=AaaoPgOqd5@mail.gmail.com>
In-Reply-To: <201101281633.44721.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9201612807214134748==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2011/1/28 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> On Friday 28 January 2011 13:37:10 ext Jessica Nilsson, you wrote:
>> diff --git a/gisi/common.h b/gisi/common.h
>> index 83a8cf5..c78f893 100644
>> --- a/gisi/common.h
>> +++ b/gisi/common.h
>> @@ -26,6 +26,8 @@
>> =C2=A0extern "C" {
>> =C2=A0#endif
>>
>> +#define PN_HOST =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x00
>> +#define PN_MODEM =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x60
>
> It looks like you are mixing up services (PN_* from 0 to 255), with device
> addresses (PN_DEV_* multiple of four from 0 to 252).
>
>> =C2=A0#define PN_COMMGR =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x10
>> =C2=A0#define PN_NAMESERVICE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0xDB
>> =C2=A0#define PN_FIREWALL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x43
>> diff --git a/gisi/modem.c b/gisi/modem.c
>> index 8750367..7201235 100644
>> --- a/gisi/modem.c
>> +++ b/gisi/modem.c
>> @@ -61,6 +61,7 @@ struct _GIsiModem {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned index;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 GHashTable *services;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gboolean subs_source;
>> + =C2=A0 =C2=A0 =C2=A0 GIsiVersion version;
>
> I can't see where this gets set?!
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int req_fd;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int ind_fd;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 guint req_watch;
>> @@ -349,11 +345,34 @@ static gboolean modem_subs_update(gpointer data)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer keyptr, value;
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIsiModem *modem =3D data;
>> - =C2=A0 =C2=A0 =C2=A0 uint8_t msg[3 + 256] =3D {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, PNS_SUBSCRIBED_RES=
OURCES_IND,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0,
>> - =C2=A0 =C2=A0 =C2=A0 };
>> + =C2=A0 =C2=A0 =C2=A0 GIsiMessage dmsg;
>> + =C2=A0 =C2=A0 =C2=A0 uint8_t msg[3 + 256] =3D { 0 };
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint8_t count =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 int msg_size =3D 0;
>> + =C2=A0 =C2=A0 =C2=A0 struct sockaddr_pn commgr =3D {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .spn_family =3D AF_PH=
ONET,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 .spn_resource =3D PN_=
COMMGR,
>> + =C2=A0 =C2=A0 =C2=A0 };
>> +
>> + =C2=A0 =C2=A0 =C2=A0 if (g_isi_modem_version_major(modem) =3D=3D 2 &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_isi_modem_version_m=
inor(modem) =3D=3D 5) {
>
> You really need to factor this check out. It's going to be a disaster when
> there are more than two versions otherwise.

This is problematic, since there is no version query by default for
the PN_COMMGR because creating the GIsiModem is not async. Also, even
the N900 modem supports both of these INDs, but the
PNS_SUBSCRIBED_RESOURCES_EXTEND_IND is blocked by a modem side
firewall.

So I think we need something different here, like flags that the
plugin can set to control which IND type gets used.

Cheers,
Aki

--===============9201612807214134748==--

