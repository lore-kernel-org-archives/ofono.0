Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F341A421F18
	for <ofono@lists.linux.dev>; Mon, 20 Jul 2026 18:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572949; cv=pass; b=t5MCwPuY2hwsm2elZdOFHpPElFHvJTBXtCL68iYpXeJxyzZOdDWnufY3YhQW9CFq/VBL2ImpDMHANIwrwllQ8S2qpGx+TkSdzjkNGlNeg/HSeY9K94FvID+/vd+edHe0iCoIqtjGWvVBMlT+cLQwFyAK0khZsTXYwnxH+NWB8GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572949; c=relaxed/simple;
	bh=CN5k2D+wLf3zgXVxLiHHb0Azk9BoTICftBODFSVAM0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M6YpXwk8+oYZXQ0n3HhdUHBfTt4NGQoNauVIjvfRv87RUMOakxn2LFgFr6Xgy2UBBcWW8VhgoGAPQzfxjngOmPNyVkgwqySYYIupgNrRs0XblzJr/o9E/wJmwrfXB2/BHjjgG6nX2njGg+IR6JBd3xRJLEc8f6GouZOwTsgJnEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qAEzmHe6; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qAEzmHe6"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66843304cbaso2700961d50.2
        for <ofono@lists.linux.dev>; Mon, 20 Jul 2026 11:42:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784572947; cv=none;
        d=google.com; s=arc-20260327;
        b=snknofwPnCtYMhEkDk4/8IFdi7O3dD8UtLx3xv2FCw2aAUkHH/v1u7ekfVZttOGWM3
         dtuS+semn3We1E34ArUa3MXkWGeezzaExe8QltUb/Ncc1tKyOPCgwFA6H2zOv7FSprl/
         /1iBAW78He5wBR26rd7xWa9SfTh4IyDdxwaSFV6Uk2qI5RNSNpBzUi4kWheJvrOtof9C
         IDYexLDWQ6pkXvS0xC4r4mReVvIgf2EeBq6yrcuMLtCjxflxu4Ij0R7ebwyK/NxgEnvA
         u02xIi9iRAOzA/kbs5o4uOVK1FuSJ/xGYEsoIlea7Lulf+BJ7TqHkJqfw66T4NKs5JnN
         eiHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=e4vGyZA7rz5LioBt2I3wxz8bVhhkUdBYyXrdVTSfX4o=;
        fh=O5IRHngt0fSSUcFrV+8MSUwUfX2bqrLg//kk/96Jjr8=;
        b=mAfyDYqfcrB4t7WPZZ3WZoVoyacZ44H347OtbLMUPVwA2s+T5WA3saPiYPFONtngJJ
         fg9YtdLyr4QbYbIoPJJvFxwTKI4KkdN6f5zcg6oy91gnZCY9hOQZlLljv80Gl5ThNeJA
         kKFJnqNCt69lE5On718Kd/hNSvuyCdY2Qzi3H3V0dL6WrXtpKfdoWF+ye3S1qVPnY+LR
         rEGyJTPmnz8QYB8nK5qoHyxVr3XiI/B2odDek5GWpRf6CY6L/oXamETWIB3VUHZxXCbH
         YEFrCOWVnl8YIKpVamab/4wg9zU70dDQnDnPRTwIi6O8I6WUYvYgZQmf+YePgk+raBVe
         2ZjQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784572947; x=1785177747; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=e4vGyZA7rz5LioBt2I3wxz8bVhhkUdBYyXrdVTSfX4o=;
        b=qAEzmHe6goGXCAfG56qG3hR3dkt+muoPLEswDkGvZKTsE97xafUTI+GEOH/vcAQGiH
         t3RQRMgkzPuEWOuxNV2kaPbJ03lE75stM1lhLEch+BZYb8PQP+4KfcC9IqfWFK/MSph7
         kckfhxu52mzUd5drfFd/koiuY4uY3fFfD2O7xSPmxA7jjS0berYwr18uztvzzfKzqpnH
         D1Sy3WFFgD1HP2/v2ZvuIEA6OZXepn1a10JkifrRe7ALVJbO171NB7hsHO0fJmMiXchD
         NCdssQ0fjRMvcT6L91J5Wev4ILqDEpAn3Soju2S3aZ92U0YdsJyRNrM8ZrGKpJNztsdu
         wBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784572947; x=1785177747;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4vGyZA7rz5LioBt2I3wxz8bVhhkUdBYyXrdVTSfX4o=;
        b=FAhxa7gGFAHaQS2pd2C8n0KsuwjDx6oBypKQ5AwYngNS/Y56HRUPzN7q452FfCupmt
         VkDXroUL0LwFQaj1/UZ7gRibMeWIh1bUBWCnA7+0NbHcxAZI1d26d0Y2Ys2yj41kqmxg
         lRrlhyL/zKIomnn+ZEZhkIjl05g9IR8PKDKXQAtkSJSl/XHyD3uFe38FsUfczLX1HlBk
         qQyMSYPSf+cIPXkQaUTTJx/7YAOKeew/ATa8CJaMRmxzctpy9YYZfHe/4n+5kutfDWky
         E7D/GjzZLfEnDr+SWsqrAfVvLS4Rmy+YDl/9b07WAgyiZ2729GjY50g1SaCgygIdVyD4
         B1xg==
X-Forwarded-Encrypted: i=1; AHgh+RoS82dLWEDfJB7LiIwRixBZuFhP1KzhJ20aSjieygKcX8NMAA9pChl+llMiacifpq3qRjwrDg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyz7Km40jxckpLt7OuZzbbFzi4XgPBoYI9QkdSBs+5WveFTB5OB
	aQ5Ct2ZDJPe7ih5LczxlEQdQrVx431MNnl9gumZz3EwV7Csp0DGNTQv7FdoFQG9yBMBmeXUFBsf
	OJ0NUq36z7yZ7GfZHwXpQo27k13lNg6Y=
X-Gm-Gg: AR+sD11eZb2eLSO2ngfuT1C9cXPZEfjjk5DTyU9u4y+LKrwI2+cM1novrPuE2Ft8tul
	9jeZ9jUcKdmjuFFVPggytbFbk98+Aa+WgTBRuCHg9804JK+/K1dpQ6w0NEnyhd7wi77ggbHMFXA
	CyD8NgdYBI7rWE2qAYVB7xCBMvXiuhg1ELrannBEqMvnUvcmvJDwUCSJ2zY2SOjd5yFxSwjvHEs
	i6D65s4C3XLYV7rKbrKKoaKS42LmNqDt6tHWhkMOaBjnSoyxWPsGyUNQdzn4Ai+0N+IINtHjS7g
	sVfqzJLUAvhQL9TpPesKcqgK4ByTVGC79keSdHDK2Iwzdw==
X-Received: by 2002:a05:690c:7342:b0:81d:cc00:cb8e with SMTP id
 00721157ae682-81ef27f1cbfmr47799267b3.37.1784572946745; Mon, 20 Jul 2026
 11:42:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260715085950.4079331-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260715085950.4079331-1-xiuzhuo.shang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 20 Jul 2026 14:42:14 -0400
X-Gm-Features: AUfX_myTXitxlkfdxrIEjuGkvYJtI1nLf-omZvhy1pvkAKg2l91oXoJ7LhniFh4
Message-ID: <CABBYNZ+D8BhV_-3n+JV3715CAfZcsteAD14xyVmjpvrvwouo_g@mail.gmail.com>
Subject: Re: [PATCH v2] gdbus: Remove broad match rule and add proxy filter support
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiuzhuo,

On Wed, Jul 15, 2026 at 4:59=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
> Problem
> -------
> On embedded platforms running continuous BLE scanning, bluetoothd
> eventually stalls with its D-Bus socket to dbus-daemon full. strace
> on a hung bluetoothd shows a repeating pattern:
>
>   sendmsg(7, {org.bluez.Device1 PropertiesChanged}, MSG_NOSIGNAL)
>       =3D -1 EAGAIN (Resource temporarily unavailable)
>   ppoll([{fd=3D7, events=3DPOLLOUT}], 1, {tv_sec=3D0, tv_nsec=3D0}) =3D 0=
 (Timeout)
>
> fd=3D7 never becomes writable; bluetoothd's GMainLoop remains stuck
> waiting for POLLOUT and cannot dispatch any further D-Bus events,
> making the daemon appear hung and unresponsive to commands.
>
> The backpressure chain that causes this:
>   1. BLE scanning generates high-rate PropertiesChanged(RSSI) signals
>      (~400/s with typical BLE traffic).
>   2. ofono's broad path_namespace=3D'/' match rule causes dbus-daemon to
>      route all these signals to ofono even though ofono has no use for
>      BLE RSSI data.
>   3. ofono's single-threaded GLib loop cannot consume them fast enough;
>      undelivered messages accumulate inside dbus-daemon (457 MB
>      observed after ~3 hours of scanning).
>   4. dbus-daemon, busy draining its write queue toward ofono, stops
>      reading from bluetoothd's socket in time; bluetoothd's kernel
>      send buffer fills up and sendmsg() returns EAGAIN.
>   5. With POLLOUT registered on fd=3D7, bluetoothd's GMainLoop stalls
>      and can no longer send D-Bus replies or signals.
>
> Fix
> ---
> Three related changes:
>
> 1. Remove the broad type=3D'signal',sender=3D<svc>,path_namespace=3D<path=
>
>    match rule from g_dbus_client_new_full(). This rule was the sole
>    feeder for the signal_func path in message_filter(). ofono never
>    calls g_dbus_client_set_signal_watch() so signal_func is always
>    NULL; the broad rule therefore served no purpose and caused
>    dbus-daemon to route every bluetoothd signal to ofono.
>
> 2. Remove the now-empty match_rules GPtrArray infrastructure
>    (field declaration, init, AddMatch loop, RemoveMatch loop, free).
>    No match rules are added to this array any more.
>
> 3. Add a generic GDBusProxyFilterFunction callback and
>    g_dbus_client_set_proxy_filter() API to GDBusClient. The filter
>    is called from parse_properties() before proxy_new(), so a FALSE
>    return prevents both proxy creation and per-device
>    PropertiesChanged watch registration. This keeps all BlueZ-
>    specific logic out of the gdbus layer.
>
>    Use this in hfp_hf_bluez5.c to skip Device1 proxies for BLE
>    random-address devices: ofono only needs BR/EDR (AddressType=3D
>    'public') devices for HFP/HSP. Skipping BLE proxies prevents
>    dbus-daemon from registering per-device PropertiesChanged match
>    rules for advertising peripherals and eliminates the remaining
>    RSSI signal delivery to ofono.

> Together these changes prevent dbus-daemon from routing BLE
> advertising signals to ofono, breaking the backpressure chain:
> dbus-daemon memory stops growing, its write queue drains, and
> bluetoothd's send buffer clears so that sendmsg() no longer returns
> EAGAIN and the GMainLoop stall is resolved.
>
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
> Changes in v2:
>  - Drop Change 1 (BLE address-type filter in parse_properties()) per
>    review feedback; BlueZ-specific logic does not belong in the gdbus
>    layer.
>  - Add generic GDBusProxyFilterFunction callback and
>    g_dbus_client_set_proxy_filter() API to GDBusClient. The filter is
>    invoked before proxy_new() so a FALSE return prevents both proxy
>    creation and per-device PropertiesChanged watch registration.
>  - Use the new filter in hfp_hf_bluez5.c to skip Device1 proxies for
>    BLE random-address devices, keeping all BlueZ-specific logic in the
>    plugin as suggested.
>  - Remove now-empty match_rules GPtrArray infrastructure (field,
>    init, AddMatch loop, RemoveMatch loop, free) and unused variables.
>  - Link to v1:
>    https://lore.kernel.org/ofono/20260710075548.1072741-1-xiuzhuo.shang@o=
ss.qualcomm.com/
>
>  gdbus/client.c          | 45 +++++++++++++++++++++--------------------
>  gdbus/gdbus.h           |  8 ++++++++
>  plugins/hfp_hf_bluez5.c | 38 ++++++++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 22 deletions(-)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index 48711ae8..fa2e75c0 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -46,7 +46,6 @@ struct GDBusClient {
>         guint watch;
>         guint added_watch;
>         guint removed_watch;
> -       GPtrArray *match_rules;
>         DBusPendingCall *pending_call;
>         DBusPendingCall *get_objects_call;
>         GDBusWatchFunction connect_func;
> @@ -61,6 +60,8 @@ struct GDBusClient {
>         GDBusClientFunction ready;
>         void *ready_data;
>         GDBusPropertyFunction property_changed;
> +       GDBusProxyFilterFunction proxy_filter;
> +       void *filter_user_data;
>         void *user_data;
>         GList *proxy_list;
>  };
> @@ -943,6 +944,14 @@ static void parse_properties(GDBusClient *client, co=
nst char *path,
>                 return;
>         }
>
> +       if (client->proxy_filter) {
> +               DBusMessageIter copy =3D *iter;
> +
> +               if (!client->proxy_filter(client, path, interface,
> +                                       &copy, client->filter_user_data))
> +                       return;
> +       }
> +
>         proxy =3D proxy_new(client, path, interface);
>         if (proxy =3D=3D NULL)
>                 return;
> @@ -1211,7 +1220,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection =
*connection,
>                                                         const char *root_=
path)
>  {
>         GDBusClient *client;
> -       unsigned int i;
>
>         if (!connection || !service)
>                 return NULL;
> @@ -1232,9 +1240,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection =
*connection,
>         client->root_path =3D g_strdup(root_path);
>         client->connected =3D FALSE;
>
> -       client->match_rules =3D g_ptr_array_sized_new(1);
> -       g_ptr_array_set_free_func(client->match_rules, g_free);
> -
>         client->watch =3D g_dbus_add_service_watch(connection, service,
>                                                 service_connect,
>                                                 service_disconnect,
> @@ -1255,14 +1260,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection=
 *connection,
>                                                 "InterfacesRemoved",
>                                                 interfaces_removed,
>                                                 client, NULL);
> -       g_ptr_array_add(client->match_rules, g_strdup_printf("type=3D'sig=
nal',"
> -                               "sender=3D'%s',path_namespace=3D'%s'",
> -                               client->service_name, client->base_path))=
;
> -
> -       for (i =3D 0; i < client->match_rules->len; i++) {
> -               modify_match(client->dbus_conn, "AddMatch",
> -                               g_ptr_array_index(client->match_rules, i)=
);
> -       }
>
>         return g_dbus_client_ref(client);
>  }
> @@ -1279,8 +1276,6 @@ GDBusClient *g_dbus_client_ref(GDBusClient *client)
>
>  void g_dbus_client_unref(GDBusClient *client)
>  {
> -       unsigned int i;
> -
>         if (client =3D=3D NULL)
>                 return;
>
> @@ -1297,13 +1292,6 @@ void g_dbus_client_unref(GDBusClient *client)
>                 dbus_pending_call_unref(client->get_objects_call);
>         }
>
> -       for (i =3D 0; i < client->match_rules->len; i++) {
> -               modify_match(client->dbus_conn, "RemoveMatch",
> -                               g_ptr_array_index(client->match_rules, i)=
);
> -       }
> -
> -       g_ptr_array_free(client->match_rules, TRUE);
> -
>         dbus_connection_remove_filter(client->dbus_conn,
>                                                 message_filter, client);
>
> @@ -1396,3 +1384,16 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusCli=
ent *client,
>
>         return TRUE;
>  }
> +
> +gboolean g_dbus_client_set_proxy_filter(GDBusClient *client,
> +                                       GDBusProxyFilterFunction proxy_fi=
lter,
> +                                       void *user_data)
> +{
> +       if (client =3D=3D NULL)
> +               return FALSE;
> +
> +       client->proxy_filter =3D proxy_filter;
> +       client->filter_user_data =3D user_data;
> +
> +       return TRUE;
> +}
> diff --git a/gdbus/gdbus.h b/gdbus/gdbus.h
> index d99c2549..cc3c4e16 100644
> --- a/gdbus/gdbus.h
> +++ b/gdbus/gdbus.h
> @@ -347,6 +347,11 @@ typedef void (* GDBusClientFunction) (GDBusClient *c=
lient, void *user_data);
>  typedef void (* GDBusProxyFunction) (GDBusProxy *proxy, void *user_data)=
;
>  typedef void (* GDBusPropertyFunction) (GDBusProxy *proxy, const char *n=
ame,
>                                         DBusMessageIter *iter, void *user=
_data);
> +typedef gboolean (* GDBusProxyFilterFunction) (GDBusClient *client,
> +                                       const char *path,
> +                                       const char *interface,
> +                                       DBusMessageIter *iter,
> +                                       void *user_data);
>
>  gboolean g_dbus_proxy_set_property_watch(GDBusProxy *proxy,
>                         GDBusPropertyFunction function, void *user_data);
> @@ -377,6 +382,9 @@ gboolean g_dbus_client_set_proxy_handlers(GDBusClient=
 *client,
>                                         GDBusProxyFunction proxy_removed,
>                                         GDBusPropertyFunction property_ch=
anged,
>                                         void *user_data);
> +gboolean g_dbus_client_set_proxy_filter(GDBusClient *client,
> +                                       GDBusProxyFilterFunction proxy_fi=
lter,
> +                                       void *user_data);
>
>  #ifdef __cplusplus
>  }
> diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> index 5ad1674f..141dc5c4 100644
> --- a/plugins/hfp_hf_bluez5.c
> +++ b/plugins/hfp_hf_bluez5.c
> @@ -791,6 +791,43 @@ static void proxy_added(GDBusProxy *proxy, void *use=
r_data)
>         device_changed(proxy, path);
>  }
>
> +static gboolean proxy_filter(GDBusClient *client, const char *path,
> +                               const char *interface, DBusMessageIter *i=
ter,
> +                               void *user_data)
> +{
> +       DBusMessageIter props, entry;
> +
> +       if (g_str_equal(BLUEZ_DEVICE_INTERFACE, interface) =3D=3D FALSE)
> +               return TRUE;
> +
> +       if (dbus_message_iter_get_arg_type(iter) !=3D DBUS_TYPE_ARRAY)
> +               return TRUE;
> +
> +       dbus_message_iter_recurse(iter, &props);
> +
> +       while (dbus_message_iter_get_arg_type(&props) =3D=3D DBUS_TYPE_DI=
CT_ENTRY) {
> +               const char *key;
> +
> +               dbus_message_iter_recurse(&props, &entry);
> +               dbus_message_iter_get_basic(&entry, &key);
> +
> +               if (g_str_equal(key, "AddressType") =3D=3D TRUE) {
> +                       DBusMessageIter var;
> +                       const char *addr_type;
> +
> +                       dbus_message_iter_next(&entry);
> +                       dbus_message_iter_recurse(&entry, &var);
> +                       dbus_message_iter_get_basic(&var, &addr_type);
> +
> +                       return !g_str_equal(addr_type, "random");
> +               }
> +
> +               dbus_message_iter_next(&props);
> +       }
> +
> +       return TRUE;
> +}
> +
>  static void property_changed(GDBusProxy *proxy, const char *name,
>                                         DBusMessageIter *iter, void *user=
_data)
>  {
> @@ -844,6 +881,7 @@ static int hfp_init(void)
>         g_dbus_client_set_connect_watch(bluez, connect_handler, NULL);
>         g_dbus_client_set_proxy_handlers(bluez, proxy_added, NULL,
>                                                 property_changed, NULL);
> +       g_dbus_client_set_proxy_filter(bluez, proxy_filter, NULL);

I don't really follow; would this register a proxy filter and
automatically remove it on the first match of an AddressType=3Drandom??
Sounds not really useful to me, what is the difference if we don't use
set_proxy_filter above?

>
>         ofono_handsfree_audio_ref();
>
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
