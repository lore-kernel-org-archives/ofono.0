Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953C043713E
	for <ofono@lists.linux.dev>; Mon, 13 Jul 2026 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951243; cv=pass; b=hrDfaFEg6IxaerB3bN65s9DNJCrdKz8S2O+pJiu4P0/tjAr9yUbbF4/+jSqu0ocF5Aq21L0V0i0HCrUDn4H2NXkRj22ZaDoIc2Rs2NsJI/0zY3cE3JHh539nyaOUoFPBw4pUDbsuuS7jYcdUdiwrtgDxWQvWNO3nMCIx3wYCH78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951243; c=relaxed/simple;
	bh=fg2Z8gaLDa3vs/K4EHOJO1xgJdokcwbLDICdq0EmYz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oy51w0xFMwneTSja663f0p7zv2Cb10eg9vDkUD6bB+H0rkOOTuYn2hi+yb/yGl2CPni8SucWuLxjBRkHhwYOh+s98U0qAC+eR3szcq59RMtYGYCCt/yaUygjrsu+yS9VL1ZwXnpr9qTgIkNXJ8EUyn+jGZkt4fTGJeUKikJ1nLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jC+Sq1vk; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jC+Sq1vk"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-66493875766so5201364d50.0
        for <ofono@lists.linux.dev>; Mon, 13 Jul 2026 07:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783951241; cv=none;
        d=google.com; s=arc-20260327;
        b=qg4tydgUB6dJtxjXHFE1ol/MeXAOZMn5YbrYnaevpjEsQzpd4hDpUtcfuYy1fbdpKL
         EEEXyIIcuom41YaDRvnTHxexHL0lsQ2MJOzaZRe+Ri57lNMoEdo+MgJI5+HNXn+H/p/g
         Mm5LYubKopecgvTy5v/7IN27F2n46iRhxXnG+8DFy4rJUhQrH3SHX8wxNAtiIGxgtuSD
         L8y7LgBjqBRl/LTH5mhxyYev5/mnITSSsBB39nKRdD/lxUCcHo+7PpmZAkaTSoVv5fTo
         pPZKiCUeYfm0V+xqzHKL2HCX1tTbPcAuYqLEsHdNaY+dv4/EIkmMwPuw9Xz3Zzfok61N
         eNDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ytvSfPezMzozz2pHN90oslvwQ6mYc/Imt7ZobMq9mY8=;
        fh=icnR0QEZwCrP6GqMXeZBIiiDX+Al2Zsq9hggNL2V80c=;
        b=sJM4mQbDZh4PayJcBpPFluc0RENZ0pq5FNl6VQ26nhNw3SFfkXkXtJJes5nFIWi9+5
         6Tuh/Ol7Kp4eOM/BBenHUp0/zSPt9dF6oIUfSKtA2hDZRP4u7E1OHghPqeqs6bC2Vyg1
         b/7mMe6rYLUZ9FJMTQ2aU9NkJr58oRHVNeThlMOELdA7Al5DpfXcQc/w2uryEBSik6KC
         c58vdJ5ZRDs5ZzMxxVsLEmo8tXWghtrLZ8JC9mE383qfF+DJFaiBtsU/pSVZaPuR+eqf
         6nldfYvuVsnEKmXBe6T0nLeMJb7Ti6jOBt4GWWT206Jr+B/9Xw5pjVuS9sUqnQlDN7ZX
         f81g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783951241; x=1784556041; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ytvSfPezMzozz2pHN90oslvwQ6mYc/Imt7ZobMq9mY8=;
        b=jC+Sq1vkmissh9ho44mku0dtbLg1OUTOZTWyxj/wN6yEv78egS8mqGBowWNnPLE/Zg
         x3gtymWSFY3gDjmm9mObjzxe7M47ZK/1+mrHih4nC2BixOLdIiokSeEZRv/RZb7sYdYo
         XQ5wuM12F5faZW6am7ILehIBuYRlBgEGEqBM6nrMzIqCgvVXd9WKlluj+5yJN3TXPpVk
         3spX1gHqbNalDaNoR+Emt2D6nWRQEB+M78yqFmJqIz3H1uTHbuuvgaTarEyfdreByeL2
         2spwGiCiu4uDc2r9GBNIXCmLXV50r1JFvSwTMfTFWU0QfQtNcnCN+0hQLyd3x4Refc3S
         dAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783951241; x=1784556041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytvSfPezMzozz2pHN90oslvwQ6mYc/Imt7ZobMq9mY8=;
        b=mOeQXqmwKKLb5acRNNXR5mNOqJB/pTtjTCvURrcPMAtmx+6Dlas2B/om7HohArKTNy
         eJxcley01GPJFFDFZWTs2Tb/0P+0zGyCiMmM6d9/kFE7BwrcZeTj1qRNQkkuilDMqMRQ
         jfrfyEoXAa37Vo/ihvtMW10XHMT9hqDBe2NRAAgLiRIhSu/VfpXRwc7hUE0jv38gkjBr
         LFmCx9kBpICD0ItRLRKn7QK9TRhthnVKwBlMx8fdQ8EOyBmhjbrhkpyDEZJvjIB5V6jq
         V4A58WvlpHUNOX8cBrEqNoqIZPwV1DQzbDNLK8/wGrAYosh2sJGc+tPSvb1Xtc3dkUyd
         ztVA==
X-Forwarded-Encrypted: i=1; AHgh+RqeBQPUZbXpj0hf8zZrGqDGO2kEA9PtNjl9yqkrKKA8HVbfUEtj1Vtfogu1rZd67mH52EbKuA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwnVghtPN36xDxfneI1CEvuB4sH9XEMAWIn94nBm+TStkwkAViG
	StVvIcyD9yTMbBrjhmE+BKgR3fFEU3MWzqas+e9XYuBSoj0T/mk7iSzJZDrzrHnsQ4sLP0W/9Mn
	OG+sZMjRx6g4x2Ky+/rGH0roxjHAyo2Y=
X-Gm-Gg: AfdE7cnRoDrz0UqeaSlcrUvIqciZNRV/qrjEDrZrnITGOHmuzFjOqUoyjByJDfraqLb
	TvFFb0AXIAVrJc/vbcmMtq6GoGUGhyD+jEvok/pkdUCZ+hirxjQV5GDIwFTgUywN/Flp6SXsbnk
	ZF5XUJtfLp+prwqQtR/hjRyC2sEA0/jkqQldrt8VL7y9ay4FsjfN1WSE13nmboKYyVkssyUcoX+
	RPfbySaG1wkrO5rzB/zoqDib0XKftnv4TLeaRV7GFhybPyfFeq3L8nUOnkJxG3QFLCPYhKi6QJy
	9ATuizs79AIk3sEatE3ryYsjdc38mY+mbpbZvsApxsPMqR3ffZfAN2kMB5c=
X-Received: by 2002:a05:690e:c4e:b0:667:e04a:8a63 with SMTP id
 956f58d0204a3-667e04a97e3mr5289349d50.19.1783951238618; Mon, 13 Jul 2026
 07:00:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
 <CABBYNZJrrQO5XU1yC-HOry1eEaF8fBKV_jK4g3A+qJTAtw0Qqg@mail.gmail.com> <0b6a3ae6-d8a8-409d-844b-be4be14917d3@oss.qualcomm.com>
In-Reply-To: <0b6a3ae6-d8a8-409d-844b-be4be14917d3@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 Jul 2026 11:00:26 -0300
X-Gm-Features: AVVi8Ce8Dp0tC8yu74einqn_vRdads2YN-08_asUlI-J3hk_HzYL6tF15yniAZY
Message-ID: <CABBYNZ+-ybGUPPtQ3xuwHfewt4w6C4CTf0cYXbo3AZ9+vqDGxA@mail.gmail.com>
Subject: Re: [PATCH v1] gdbus: Skip BLE random-address devices and remove
 broad match rule
To: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
Cc: denkenz@gmail.com, ofono@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	cheng.jiang@oss.qualcomm.com, quic_chezhou@quicinc.com, 
	wei.deng@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com, 
	mengshi.wu@oss.qualcomm.com, jinwang.li@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Xiuzhuo,

On Mon, Jul 13, 2026 at 3:03=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
>
>
> On 7/10/2026 10:12 PM, Luiz Augusto von Dentz wrote:
> > Hi Xiuzhuo,
> >
> > On Fri, Jul 10, 2026 at 3:55=E2=80=AFAM Xiuzhuo Shang
> > <xiuzhuo.shang@oss.qualcomm.com> wrote:
> >>
> >> Two related changes to reduce dbus-daemon load caused by high-rate
> >> BLE advertising signals:
> >>
> >> 1. In parse_properties(), skip creating a GDBusProxy for Device1
> >>    objects whose AddressType is 'random' (BLE-only devices). Each
> >>    proxy registers a per-device PropertiesChanged watch via
> >>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
> >>    advertising simultaneously, this results in hundreds of match rules
> >>    and dbus-daemon routing thousands of RSSI PropertiesChanged signals
> >>    per second to ofono, none of which ofono processes. The
> >>    AddressType property is available in the InterfacesAdded dict at
> >>    the time parse_properties() is called, so the check is reliable
> >>    and race-free.
> >>
> >>    BR/EDR devices (AddressType=3D'public') are unaffected: their proxi=
es
> >>    are created as before, and the property_changed callback continues
> >>    to receive Paired and ServicesResolved updates needed for HFP/HSP.
> >>
> >> 2. In g_dbus_client_new_full(), remove the broad
> >>    type=3D'signal',sender=3D<service>,path_namespace=3D<path> match ru=
le.
> >>    This rule was the sole feeder for the signal_func path in
> >>    message_filter(). ofono never calls g_dbus_client_set_signal_watch(=
)
> >>    so signal_func is always NULL; the broad rule therefore served no
> >>    purpose and caused dbus-daemon to route every bluetoothd signal
> >>    (including all BLE PropertiesChanged) to ofono.
> >>
> >>    InterfacesAdded and InterfacesRemoved are already covered by the
> >>    precise watches registered via g_dbus_add_signal_watch() earlier in
> >>    g_dbus_client_new_full(), so no functionality is lost.
> >
> > Looks like this is on ofono though, why are you chaning the BlueZ side?
>
> Regarding your suggestion to move the BLE filter to hfp_hf_bluez5.c: filt=
ering in proxy_added()
> would only prevent ofono from processing BLE devices at the application l=
evel. The per-device
> PropertiesChanged watch is registered inside proxy_new(), which is called=
 before proxy_added(). So
> dbus-daemon would still route all RSSI signals to the process =E2=80=94 t=
he D-Bus pressure problem would
> remain unchanged.
>
> I will drop the change from the gdbus patch per your feedback
>
> >
> >> Together these two changes prevent dbus-daemon from routing BLE
> >> advertising PropertiesChanged signals to ofono entirely, eliminating
> >> the dbus-daemon memory growth and bluetoothd socket backpressure seen
> >> after hours of BLE scanning.
> >>
> >> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> >> ---
> >>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
> >>  1 file changed, 38 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/gdbus/client.c b/gdbus/client.c
> >> index 48711ae8..dd3c17f9 100644
> >> --- a/gdbus/client.c
> >> +++ b/gdbus/client.c
> >> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client,=
 const char *path,
> >>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) =3D=3D T=
RUE)
> >>                 return;
> >>
> >> +       /*
> >> +        * Skip BLE devices (AddressType=3D'random') to avoid register=
ing a
> >> +        * per-device PropertiesChanged watch for every advertising BL=
E
> >> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; th=
e
> >> +        * high-rate RSSI PropertiesChanged signals from BLE scanners =
cause
> >> +        * dbus-daemon memory bloat and socket backpressure in bluetoo=
thd.
> >> +        *
> >> +        * The AddressType property is present in the InterfacesAdded =
dict
> >> +        * (iter) at this point, so it can be checked before proxy_new=
().
> >> +        */
> >> +       if (g_str_equal(interface, "org.bluez.Device1") =3D=3D TRUE) {
> >> +               DBusMessageIter props, entry;
> >> +               DBusMessageIter copy =3D *iter;
> >> +
> >> +               if (dbus_message_iter_get_arg_type(&copy) =3D=3D DBUS_=
TYPE_ARRAY) {
> >> +                       dbus_message_iter_recurse(&copy, &props);
> >> +                       while (dbus_message_iter_get_arg_type(&props) =
=3D=3D
> >> +                                               DBUS_TYPE_DICT_ENTRY) =
{
> >> +                               const char *key;
> >> +                               dbus_message_iter_recurse(&props, &ent=
ry);
> >> +                               dbus_message_iter_get_basic(&entry, &k=
ey);
> >> +                               if (g_str_equal(key, "AddressType") =
=3D=3D TRUE) {
> >> +                                       DBusMessageIter var;
> >> +                                       const char *addr_type;
> >> +                                       dbus_message_iter_next(&entry)=
;
> >> +                                       dbus_message_iter_recurse(&ent=
ry, &var);
> >> +                                       dbus_message_iter_get_basic(&v=
ar,
> >> +                                                               &addr_=
type);
> >> +                                       if (g_str_equal(addr_type,
> >> +                                                       "random") =3D=
=3D TRUE)
> >> +                                               return;
> >> +                                       break;
> >> +                               }
> >> +                               dbus_message_iter_next(&props);
> >> +                       }
> >> +               }
> >> +       }
> >
> > Nack, not going to introduce BlueZ specific logic into gdbus like
> > this. If we need to rate limit the RSSI notification then it means
> > it's not suitable to be a property, but I believe we have a threshold
> > logic in the likes of device_set_rssi_with_delta so perhaps we shall
> > check why it is not working in your case.
>
> I investigated why device_set_rssi_with_delta is not working in our case.
>
> Root cause in BlueZ
>
>   The customer scans with the following bluetoothctl sequence:
>
>   menu scan =E2=86=92 transport le =E2=86=92 duplicate-data off =E2=86=92=
 back =E2=86=92 scan le

Ok, that is 1 not the default behavior and 2 if they are setting
duplicate-data off that means they want to see all advertisements, so
this is working as intended.

>   scan le calls SetDiscoveryFilter({'Transport': 'le'}) =E2=80=94 a trans=
port-only filter with no RSSI or
>   pathloss condition. In btd_adapter_device_found() (src/adapter.c):
>
>   if (adapter->filtered_discovery)
>       device_set_rssi_with_delta(dev, rssi, 0);   /* delta forced to 0 */
>   else
>       device_set_rssi(dev, rssi);                  /* delta =3D RSSI_THRE=
SHOLD =3D 8 */
>
>   filtered_discovery is set true whenever current_discovery_filter is non=
-NULL (adapter.c:1872), which
>    happens for any SetDiscoveryFilter() call =E2=80=94 including a transp=
ort-only filter. With
>   delta_threshold=3D0, the condition delta < 0 is never true, so g_dbus_e=
mit_property_changed("RSSI")
>   fires on every BLE advertisement regardless of whether the RSSI value c=
hanged. With 280+ BLE devices
>    advertising continuously, this produces ~95 PropertiesChanged(RSSI) si=
gnals per second that flood
>   dbus-daemon.

Yeah, that is what you get to set duplicate-data off, that said ~95
PropertiesChanged per seconds in not a lot of data, perhaps you are
hitting a process that don't consume the events immediately as it
should then the D-Bus daemon have to queue more and more memory?

>   The delta=3D0 path was presumably intended for clients that set RSSI/pa=
thloss proximity filters, so
>   that is_filter_match() gets precise RSSI tracking. A transport-only fil=
ter does not involve any
>   proximity condition, so forcing delta=3D0 is unnecessary in that case.
>
> Proposed BlueZ fix direction
>
>   Only apply delta=3D0 when at least one active client filter has a real =
proximity condition (RSSI or
>   pathloss):
>
>   static bool discovery_filter_has_proximity(struct btd_adapter *adapter)
>   {
>       GSList *l;
>       for (l =3D adapter->discovery_list; l; l =3D g_slist_next(l)) {
>           struct discovery_client *client =3D l->data;
>           struct discovery_filter *item =3D client->discovery_filter;
>           if (item && (item->rssi !=3D DISTANCE_VAL_INVALID ||
>                        item->pathloss !=3D DISTANCE_VAL_INVALID))
>               return true;
>       }
>       return false;
>   }

Duplicate data does consider RSSI as well, so the real problem seems
to be why disabling duplicate filtering is required since that is what
causes the RSSI threshold logic not to be used. Or perhaps you don't
trust your controller to do duplicate filtering. If so, we've gone
full circle because if something causes too much spamming, it's also
bad at the HCI driver, into the mgmt interface, etc, until it reaches
D-Bus, which is why BlueZ defaults to duplicate filtering.

>   /* in btd_adapter_device_found() */
>   if (adapter->filtered_discovery &&
>       discovery_filter_has_proximity(adapter))
>       device_set_rssi_with_delta(dev, rssi, 0);
>   else
>       device_set_rssi(dev, rssi);
>
>   Could you advise whether this is the right approach, or if there is a b=
etter place to fix this?
>
>   then I will Submit a separate BlueZ patch for the delta=3D0 fix once we=
 agree on the approach.
>
> >
> >>         proxy =3D proxy_lookup(client, path, interface);
> >>         if (proxy) {
> >>                 update_properties(proxy, iter, FALSE);
> >> @@ -1255,14 +1293,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnect=
ion *connection,
> >>                                                 "InterfacesRemoved",
> >>                                                 interfaces_removed,
> >>                                                 client, NULL);
> >> -       g_ptr_array_add(client->match_rules, g_strdup_printf("type=3D'=
signal',"
> >> -                               "sender=3D'%s',path_namespace=3D'%s'",
> >> -                               client->service_name, client->base_pat=
h));
> >> -
> >> -       for (i =3D 0; i < client->match_rules->len; i++) {
> >> -               modify_match(client->dbus_conn, "AddMatch",
> >> -                               g_ptr_array_index(client->match_rules,=
 i));
> >> -       }
> >
> > This perhaps has a merit, but I can't recall what this watch was for.
> > Is it matching every signal from the sender? It seems it was introduce
> > before the watch infra existed, so if we can safely remove it we can
> > perhaps remove the whole client-->match_rules.
> >
> >>         return g_dbus_client_ref(client);
> >>  }
> >> --
> >> 2.43.0
> >>
> >
> >
>


--=20
Luiz Augusto von Dentz
