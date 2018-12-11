Content-Type: multipart/mixed; boundary="===============8105013571825069663=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] xmm7modem: implemnetation of coexistence functionality
Date: Tue, 11 Dec 2018 10:52:58 -0600
Message-ID: <e0c58a6b-6a19-2611-8be6-5c99256f47f9@gmail.com>
In-Reply-To: <1544529237-26071-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8105013571825069663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On 12/11/2018 05:53 AM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>

Author info is still incomplete, we need something like: FirstName =

LastName <user@email.com>

> =

> Added coex implementation in xmm7modem plugin
> ---
>   plugins/xmm7xxx.c | 922 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 922 insertions(+)
> =


When compiling I get:

   CC       plugins/xmm7xxx.o
plugins/xmm7xxx.c:146:14: error: no previous declaration for =

=E2=80=98coex_agent_matches=E2=80=99 [-Werror=3Dmissing-declarations]
  ofono_bool_t coex_agent_matches(struct coex_agent *agent,
               ^~~~~~~~~~~~~~~~~~
plugins/xmm7xxx.c:152:6: error: no previous declaration for =

=E2=80=98coex_agent_set_removed_notify=E2=80=99 [-Werror=3Dmissing-declarat=
ions]
  void coex_agent_set_removed_notify(struct coex_agent *agent,
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
plugins/xmm7xxx.c:176:6: error: no previous declaration for =

=E2=80=98coex_agent_send_release=E2=80=99 [-Werror=3Dmissing-declarations]
  void coex_agent_send_release(struct coex_agent *agent)
       ^~~~~~~~~~~~~~~~~~~~~~~
plugins/xmm7xxx.c:181:6: error: no previous declaration for =

=E2=80=98coex_agent_free=E2=80=99 [-Werror=3Dmissing-declarations]
  void coex_agent_free(struct coex_agent *agent)
       ^~~~~~~~~~~~~~~
plugins/xmm7xxx.c:211:20: error: no previous declaration for =

=E2=80=98coex_agent_new=E2=80=99 [-Werror=3Dmissing-declarations]
  struct coex_agent *coex_agent_new(const char *path, const char *sender,
                     ^~~~~~~~~~~~~~
plugins/xmm7xxx.c:233:5: error: no previous declaration for =

=E2=80=98coex_agent_coex_wlan_notify=E2=80=99 [-Werror=3Dmissing-declaratio=
ns]
  int coex_agent_coex_wlan_notify(struct coex_agent *agent,
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
plugins/xmm7xxx.c:286:5: error: no previous declaration for =

=E2=80=98coex_agent_coex_bt_notify=E2=80=99 [-Werror=3Dmissing-declarations]
  int coex_agent_coex_bt_notify(struct coex_agent *agent,
      ^~~~~~~~~~~~~~~~~~~~~~~~~
plugins/xmm7xxx.c:366:13: error: no previous declaration for =

=E2=80=98ofono_wlan_bw_to_string=E2=80=99 [-Werror=3Dmissing-declarations]
  const char *ofono_wlan_bw_to_string(int band)
              ^~~~~~~~~~~~~~~~~~~~~~~
plugins/xmm7xxx.c:382:6: error: no previous declaration for =

=E2=80=98xmm_get_band_string=E2=80=99 [-Werror=3Dmissing-declarations]
  void xmm_get_band_string(int lte_band, char *band)
       ^~~~~~~~~~~~~~~~~~~


> +
> +const char *ofono_wlan_bw_to_string(int band)

no ofono prefix please.

> +{
> +	switch (band) {
> +	case WLAN_BW_20MHZ:
> +		return "20MHz";
> +	case WLAN_BW_40MHZ:
> +		return "40MHz";
> +	case WLAN_BW_80MHZ:
> +		return "80MHz";
> +	case WLAN_BW_UNSUPPORTED:
> +		return "UnSupported";
> +	}
> +
> +	return "";
> +}
> +
> +void xmm_get_band_string(int lte_band, char *band)
> +{
> +	int band_lte =3D lte_band-NET_BAND_LTE_1+1;

coding style item m1

> +
> +	if (lte_band >=3D NET_BAND_LTE_1 && lte_band <=3D NET_BAND_LTE_43)
> +		sprintf(band, "BAND_LTE_%d", band_lte);
> +	else
> +		sprintf(band, "INVALID");
> +}
> +

<snip>

> +static void coex_get_plmn_history_cb(gboolean ok, GAtResult *result,
> +					gpointer user_data)
> +{
> +	struct xmm7xxx_coex *coex =3D user_data;
> +	struct plmn_hist *list =3D NULL;
> +	GAtResultIter iter;
> +	int list_size =3D 0, count;
> +	DBusMessage *reply;
> +	DBusMessageIter itr, arr;
> +
> +	DBG("ok %d", ok);
> +
> +	if (!ok) {
> +		__ofono_dbus_pending_reply(&coex->pending,
> +				__ofono_error_failed(coex->pending));
> +		return;
> +	}
> +
> +	g_at_result_iter_init(&iter, result);
> +
> +	while (g_at_result_iter_next(&iter, "+XNVMPLMN:")) {
> +		if (!list_size)
> +			list =3D g_new0(struct plmn_hist, ++list_size);
> +		else
> +			list =3D g_renew(struct plmn_hist, list, ++list_size);
> +
> +		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].mcc);
> +		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].mnc);
> +		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].fdd);
> +		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].tdd);
> +		g_at_result_iter_next_number(&iter, (int *)&list[list_size - 1].bw);

These lines are > 80 characters.  Speaking of which, these casts look =

wrong.  g_at_result_iter_next_number expects an integer and would be =

writing 4 bytes to the out parameter pointer.  But at least some of your =

structure members are shorts.  So this should cause valgrind to complain.

> +
> +		DBG("list_size =3D %d", list_size);
> +	}
> +
> +	reply =3D dbus_message_new_method_return(coex->pending);
> +	dbus_message_iter_init_append(reply, &itr);
> +
> +	dbus_message_iter_open_container(&itr, DBUS_TYPE_ARRAY,
> +				DBUS_STRUCT_BEGIN_CHAR_AS_STRING
> +				DBUS_TYPE_ARRAY_AS_STRING
> +				DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
> +				DBUS_TYPE_STRING_AS_STRING
> +				DBUS_TYPE_VARIANT_AS_STRING
> +				DBUS_DICT_ENTRY_END_CHAR_AS_STRING
> +				DBUS_STRUCT_END_CHAR_AS_STRING,
> +				&arr);
> +
> +	for (count =3D 0; count < list_size; count++)
> +		append_plmn_history_struct_list(list, &arr);
> +
> +	dbus_message_iter_close_container(&itr, &arr);
> +
> +	reply =3D dbus_message_new_method_return(coex->pending);
> +	__ofono_dbus_pending_reply(&coex->pending, reply);
> +
> +	if (list)
> +		g_free(list);

g_free already checks for NULL, so the if isn't needed.

> +}
> +

<snip>

> +static int xmm_coex_enable(struct ofono_modem *modem, void *data)
> +{
> +	struct xmm7xxx_coex *coex;
> +	DBusConnection *conn =3D ofono_dbus_get_connection();
> +	const char *path =3D ofono_modem_get_path(modem);
> +	coex =3D g_new0(struct xmm7xxx_coex, 1);
> +
> +	DBG("coex enable");
> +
> +	coex->chat =3D data;
> +	coex->modem =3D modem;
> +	coex->bt_active =3D 0;
> +	coex->wlan_active =3D 0;
> +	coex->wlan_bw =3D WLAN_BW_20MHZ;
> +	coex->lte_band =3D g_strdup("INVALID");
> +	coex->session_agent =3D NULL;
> +
> +	if (!g_at_chat_send(coex->chat, "AT+XCCINFO=3D1", none_prefix,

coding style item m1

> +				NULL, NULL, NULL))
> +		goto out;
> +
> +	if(!g_at_chat_send(coex->chat, "AT+XNRTCWS=3D7", none_prefix,

item m1

> +				NULL, NULL, NULL))
> +		goto out;
> +
> +	if (!g_dbus_register_interface(conn, path, OFONO_COEX_INTERFACE,
> +					coex_methods,
> +					coex_signals,
> +					NULL, coex, coex_cleanup)) {
> +		ofono_error("Could not register %s interface under %s",
> +					OFONO_COEX_INTERFACE, path);
> +		goto out;
> +	}
> +
> +	ofono_modem_add_interface(modem, OFONO_COEX_INTERFACE);
> +
> +	g_at_chat_register(coex->chat, "+XNRTCWSW:", xmm_coex_w_notify,
> +					FALSE, coex, NULL);
> +	g_at_chat_register(coex->chat, "+XNRTCWSB:", xmm_coex_b_notify,
> +					FALSE, coex, NULL);
> +	g_at_chat_register(coex->chat, "+XCCINFO:", xmm_lte_band_notify,
> +					FALSE, coex, NULL);
> +	return 0;
> +
> +out:
> +	g_free(coex->lte_band);
> +	g_free(coex);
> +	return -EIO;
> +}
> +

Regards,
-Denis

--===============8105013571825069663==--

