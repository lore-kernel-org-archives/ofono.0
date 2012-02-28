Content-Type: multipart/mixed; boundary="===============5345600635108255931=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: [RFC v0] ofono: Only register network when APN is set
Date: Tue, 28 Feb 2012 16:06:17 +0200
Message-ID: <CAHiDW_HN1X7zX-TpHgpwF=FL_zYxSPVYgtWJyiONERiAbX65WQ@mail.gmail.com>
In-Reply-To: <1330420763-8244-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5345600635108255931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 28, 2012 at 11:19 AM, Daniel Wagner <wagi@monom.org> wrote:
> From: Daniel Wagner <daniel.wagner@bmw-carit.de>
>
> We should now show a network without an APN.
> ---
> I have not tested this one. But something like this should do
> the trick. Maybe someone with deeper knowledge on the APN
> behavior could explain under which circumstances the APN is set, e.g.
> see the netreg vs apn setting in this patch. Not sure if this is correct.
>
> cheers,
> daniel

Thanks Daniel. This sort of works after some fixes but it looks like
there are still issues if modem or context properties change. I'll
have a go a fixing it later today. I'm including my initial comments
below for reference (just in case I don't manage to fix them).

Also while I remember: cm_context_added() does a lookup on modem_hash
when it probably shoud use context_hash. I'll include this in the
patches.

> =C2=A0plugins/ofono.c | =C2=A0 25 +++++++++++++++++++++++++
> =C2=A01 files changed, 25 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/ofono.c b/plugins/ofono.c
> index d87d7b6..c92c3cc 100644
> --- a/plugins/ofono.c
> +++ b/plugins/ofono.c
> @@ -105,6 +105,9 @@ enum ofono_api {
> =C2=A0* the plugin about IP configuration through the updating the contex=
t's
> =C2=A0* properties.
> =C2=A0*
> + * The network is only registered at the core when the AccessPointName
> + * has been set.
> + *
> =C2=A0* CDMA working flow:
> =C2=A0*
> =C2=A0* When a new modem appears, the plugin always powers it up. This
> @@ -172,6 +175,7 @@ struct modem_data {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* ConnectionContext Interface */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0connman_bool_t active;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0connman_bool_t set_active;
> + =C2=A0 =C2=A0 =C2=A0 char *apn;

probably makes sense to have this in network_context -- easier to keep
them in sync if e.g. context disappears.

>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* SimManager Interface */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0char *imsi;
> @@ -1105,6 +1109,10 @@ static int add_cm_context(struct modem_data *modem=
, const char *context_path,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dbus_message_iter_get_basic(&value, &active);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0DBG("%s Active %d", modem->path, active);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (g_str_equal=
(key, "AccessPointName") =3D=3D TRUE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 dbus_message_iter_get_basic(&value, &modem->apn);

copying needed.

> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG("%s AccessPointName %s", modem->path, modem->apn);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbus_message_iter_=
next(dict);
> @@ -1180,6 +1188,19 @@ static gboolean context_changed(DBusConnection *co=
nnection,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0set_connected(modem);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0set_disconnected(modem);
> + =C2=A0 =C2=A0 =C2=A0 } else if (g_str_equal(key, "AccessPointName") =3D=
=3D TRUE) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(modem->apn);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_get_=
basic(&value, &modem->apn);
> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("%s AccessPointNam=
e %s", modem->path, modem->apn);

copy needed as well

> +
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (has_interface(mode=
m->interfaces,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 OFONO_API_NE=
TREG) =3D=3D TRUE &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 modem->network !=3D NULL) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 DBG("Register network at core");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 add_network(modem);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }

* if a network exists and apn is empty -> remove_network()
* if a network does not exist and netreg iface is supported  and apn
is not empty -> add_network()

also, probably need to call set_connected() if Active is set?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0return TRUE;
> @@ -1518,6 +1539,9 @@ static void netreg_properties_reply(struct modem_da=
ta *modem,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (modem->apn =3D=3D NULL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> +

This doesn't actually work as the 'empty' apn is "". Now that I think
about it, it would be safer and easier to just save a boolean
apn_is_valid...

> =C2=A0 =C2=A0 =C2=A0 =C2=A0add_network(modem);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (modem->active =3D=3D TRUE)
> @@ -2187,6 +2211,7 @@ static void remove_modem(gpointer data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(modem->serial);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(modem->name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(modem->imsi);
> + =C2=A0 =C2=A0 =C2=A0 g_free(modem->apn);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(modem->path);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0g_free(modem);
> --
> 1.7.9.48.g85da4d
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============5345600635108255931==--

