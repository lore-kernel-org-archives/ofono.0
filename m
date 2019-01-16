Content-Type: multipart/mixed; boundary="===============5184144888919828779=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] modem: add support to clear cached pins.
Date: Wed, 16 Jan 2019 07:52:08 +0100
Message-ID: <CAKSBH7HnhfkkxGL8+-Y8hhKm_W8dRt8FV_3-YgAifypvExhwjQ@mail.gmail.com>
In-Reply-To: <1547621131-7600-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5184144888919828779==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nandini,

On Wed, Jan 16, 2019 at 7:45 AM Nandini Rebello
<nandini.rebello@intel.com> wrote:
>
> Adding support to clear cached pins when modem is powered off.

but then this whole feature is useless because most of the modems
disappear from the bus when crashing and restarting,
and when they re-enumerate they are automatically Powered=3Dfalse

how do you go round this for your template modem?

> ---
>  src/modem.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/modem.c b/src/modem.c
> index bc46275..baacdc8 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -1130,6 +1130,9 @@ static DBusMessage *modem_set_property(DBusConnecti=
on *conn,
>                 if (modem->lockdown)
>                         return __ofono_error_access_denied(msg);
>
> +               if (!powered)
> +                       ofono_sim_clear_cached_pins(modem->sim);
> +
>                 err =3D set_powered(modem, powered);
>                 if (err < 0) {
>                         if (err !=3D -EINPROGRESS)
> --
> 2.7.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

Regards,
Giacinto

--===============5184144888919828779==--

