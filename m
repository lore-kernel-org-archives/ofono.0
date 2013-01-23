Content-Type: multipart/mixed; boundary="===============4745064485050705663=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH 03/10] hfp_hf_bluez5: Register modem for HFP AG capable
 devices
Date: Wed, 23 Jan 2013 11:22:41 -0300
Message-ID: <20130123142241.GB6545@samus>
In-Reply-To: <50FF6E2E.6030706@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4745064485050705663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 22:59 Tue 22 Jan, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 01/22/2013 03:43 PM, Vinicius Costa Gomes wrote:
> >Now that we are able to keep track of devices appearing and
> >disappearing from BlueZ, we are able to register the modem when a
> >device that supports the HFP AG UUID appears.
> >---
> >  plugins/bluez5.h        |  1 +
> >  plugins/hfp_hf_bluez5.c | 88 +++++++++++++++++++++++++++++++++++++++++=
+++++++-
> >  2 files changed, 88 insertions(+), 1 deletion(-)
> >

[snip]

> >@@ -184,11 +235,36 @@ static void proxy_added(GDBusProxy *proxy, void *u=
ser_data)
> >  	g_hash_table_insert(devices_proxies, g_strdup(path),
> >  						g_dbus_proxy_ref(proxy));
> >  	DBG("Device proxy: %s(%p)", path, proxy);
> >+
> >+	if (g_dbus_proxy_get_property(proxy, "UUIDs",&iter) =3D=3D FALSE)
> >+		return;
> >+
> >+	parse_uuids(&iter,&uuids);
> >+
> >+	for (l =3D uuids; l; l =3D l->next) {
> >+		const char *uuid =3D l->data;
> >+
> =

> Next we traverse the list
> =

> >+		if (g_str_equal(uuid, HFP_AG_UUID) =3D=3D TRUE)
> >+			break;
> =

> And if we find the UUID we break
> =

> >+	}
> >+
> >+	g_slist_free_full(uuids, g_free);
> >+
> =

> And now we free the all the g_strdup()ed strings.  Why? Why do we
> bother doing all this work?  Just rename parse_uuids into something
> sensible, like 'has_hfp_ag_uuid' and make it return a boolean.

Cool. Thanks. I made it return a gboolean, but couldn't find a standard abo=
ut
to return a gboolean or a ofono_bool_t.

> =

> >+	if (l =3D=3D NULL)
> >+		return;
> >+
> >+	if (g_dbus_proxy_get_property(proxy, "Alias",&iter) =3D=3D FALSE)
> >+		return;
> >+
> >+	dbus_message_iter_get_basic(&iter,&alias);
> >+
> >+	modem_register(path, alias);
> =

> And why do we do all this work without first checking whether the
> modem is already in the modem_hash?

This would only happen on a very uncommon case: we receive from BlueZ a
NewConnection() (we register the modem there) and after that we receive
the InterfacesAdded signal. I don't think the increase in complexity is wor=
th.
And inside the modem_register() we check if the modem is already registered.


> =

> >  }
> >
> >  static void proxy_removed(GDBusProxy *proxy, void *user_data)
> >  {
> >  	const char *interface, *path;
> >+	struct ofono_modem *modem;
> >
> >  	interface =3D g_dbus_proxy_get_interface(proxy);
> >  	path =3D g_dbus_proxy_get_path(proxy);
> >@@ -198,6 +274,12 @@ static void proxy_removed(GDBusProxy *proxy, void *=
user_data)
> >  		DBG("Device proxy: %s(%p)", path, proxy);
> >  	}
> >
> >+	modem =3D g_hash_table_lookup(modem_hash, path);
> >+	if (modem =3D=3D NULL)
> >+		return;
> >+
> >+	g_hash_table_remove(modem_hash, path);
> >+	ofono_modem_remove(modem);
> >  }
> >
> >  static void property_changed(GDBusProxy *proxy, const char *name,
> >@@ -242,6 +324,9 @@ static int hfp_init(void)
> >  		return err;
> >  	}
> >
> >+	modem_hash =3D g_hash_table_new_full(g_str_hash, g_str_equal, g_free,
> >+								NULL);
> >+
> >  	devices_proxies =3D g_hash_table_new_full(g_str_hash, g_str_equal,
> >  				g_free, (GDestroyNotify) g_dbus_proxy_unref);
> >
> >@@ -258,6 +343,7 @@ static void hfp_exit(void)
> >  	ofono_modem_driver_unregister(&hfp_driver);
> >  	g_dbus_client_unref(bluez);
> >
> >+	g_hash_table_destroy(modem_hash);
> >  	g_hash_table_destroy(devices_proxies);
> >  }
> >
> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============4745064485050705663==--

