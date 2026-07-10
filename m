Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EA3230BE9
	for <ofono@lists.linux.dev>; Fri, 10 Jul 2026 14:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692796; cv=pass; b=oOYdDuPJai6n4605DN4h0KTOUHNnLMGNR2a1BBK3wf8kiH3g5j0jDoxN2O9nN28jRtJMQjh4RMV/wyXUJ42RJfKOe2PE2TC5BvkjgiahWXgzPtoEEvAnqKw3Hrkb1/tIinnEvUAkyMqet6d0QpOae8ffR24riEsx4t30pQIXAqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692796; c=relaxed/simple;
	bh=HtuOTcMuv28AG4TC5qIlHyGf/HgRKhcxW0N1gr8M+EI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sahtv3P2aA5UOdrDy9cnuVt3z3g/yuqbHyHR9ABE72TDyjY1E1UbT0T44HZ8LlCAy6mGSBD4BeJwqH03ybpnSk3U4rn9qwN4HLjOTZJPCvZ2ZpT7nuI+27t/i37ToTH+1i6yS3YlsKy6YL+Y3ph8F4m7Yb4c3A8nj4AhIEEOtUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9T4n1G5; arc=pass smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9T4n1G5"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-667627ae83aso1420589d50.0
        for <ofono@lists.linux.dev>; Fri, 10 Jul 2026 07:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783692794; cv=none;
        d=google.com; s=arc-20260327;
        b=FuJwMyYDlkoamx+Z2Hnq65ZUr9PBUJAm6auxAhuqNvQQwhlJekm77uJq+q+IABbm+I
         qR0lmsZqiB2sbQ9KN6rRKob57E4cIHUGHE1kJukKub+j4thKPWFhHoPOLCV4lxgG7V4c
         DheJHTQCyuEDGITP3a5H+0rjOiU2Ok/JWpLwDZC/P9sT1aF1TXa7HybES4gSjamYpB4/
         SHHCsSDRL/Wj0eafVPzqoPMBETilObXf05Gwy+83h0QbP4tEx8oAXeenhpL8oi5yqDmD
         kVi6xxiB39vFJSWawmTIN3f0eS4eoOsQJpSM75QezAP0e5c9JGrEkVApeGx4508Bm0SI
         qS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OE6Zf/Uv878MLjyBZ5h8gJ9XY0REbTQDyuLB9+x5TUU=;
        fh=Ddpl4AIIxIshmt3nq/DNrqYnth+EO44SKSPPiax2+t8=;
        b=sWNyvPymOQMNgOII7FJgxgm1SFFLRxr1DDCLi8cwwNV/zuyebnx65OMS/v3CG0Ac/X
         DDAQpP5f9w0lSAcN2+kmKaWtLP+pvGl0TKT5irdDYHrjtCsPAyy0U1Fd5nHvxsLisaqA
         iKAMsxSqUzm95zTyeorOS7JouXsV8uOe9PkQhCFI1bhxDDcnoacKQplgjhv0y2MrzX0i
         4gMu1wg2OzDYy7RpMHK1taDEZC7UTcCIPkYaPBzXUnLG5hUl5tOZUXW/iGkmO2e7cf+z
         t+kBVxVB3soHxO24uUGu3UHpkNT8ye+cpi7NJM+ZhhxlYh5pvZAwyGQ4ppjsd/I8CLJv
         JzwQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783692794; x=1784297594; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OE6Zf/Uv878MLjyBZ5h8gJ9XY0REbTQDyuLB9+x5TUU=;
        b=B9T4n1G5xeJnEf6glgqTKHR22sBUJQQwwPmmJDLNWZayxTWhSOKwS97/jsu1hxzQp+
         q7Lj8fI5r7c8FeggX5rIODPd26vBourfiGuPDbWsB/RrYBcsF1g0shXXr9j/+qUpe4Zk
         L+jQHl84/ShTDWM0YuuVCsKlb9ldXStm//gqmHSJd8CAdNr/HiWHQNgur/0I1QPQpgC7
         YxPkD53Zesogr/GYLtBSnR8Ad/XVIYMDLEj7yze5msXuLxP0p4Qh/az4CpRLXyS9iZ2g
         M3bfpbiy3XvCmbJoQzusZiazUPe98swKeklso8ZTfQvJUs3dAKiO8zfC2vMjsE0VEL3w
         BReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783692794; x=1784297594;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OE6Zf/Uv878MLjyBZ5h8gJ9XY0REbTQDyuLB9+x5TUU=;
        b=PeL448qm1byV3Ih/3lRyKXpt7B/q+raE2V6aEEvi8FlY5NYkGTQ1MKIpxywcj7Kbl9
         xq/w3zLcBpoKNfqnkJR+RRwMg39IRNa9wHZNeUiZV/wGaUomDuzVSZHBV8o8aiK9bGmG
         X+Hrc2dbI2KWXGKvhaisLVgXWbL2FNwNo2/GTuUkoEb4iwa20jYgqUJO+gK18yiVYH0V
         s8hYYlZv4Z5NBmSSNWncCL0/HNPOjwk5Ce0V1duAhN1Y+tf1ZTCPtgxJOxaRb5tPnTbo
         xcj2Z66UTNwlKMk3XMVGBO/8oSFYwXmmHyW5WvfHlm8WMwFEXjlRkvB5JoB3WrryR7tE
         k9nw==
X-Forwarded-Encrypted: i=1; AHgh+RpFk3im/WBeuDkzIQe0Ar8U4exZ6x3L+W53pFpDzPQh9/QMSjdvqjMdI8U6WPO9ntLy3p01gA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfqO3rc5YsHF9y2TVsToyM32xgMVo+rAsJP+fNrMZyY61qqet0
	k5k/1vs/C4HSuMzI4Q+mumvk8ioPL9KZr4txRQx9epADmbXpmdugEk5+TVWxLgUd2HFM+oMm5Qr
	F3yTCuRRpd98I6Tf94xooG7aNIH3FLQo=
X-Gm-Gg: AfdE7cl5y2xszW3C3zVSLNB2CtvDSHl4KAweEFpydz8HJ1EUDcjwU9iVayshfl5Xhn0
	YsIUMwd71rgM5wLjqVfpJyBGxZRkAi+E7k9cbow9efoQ8gj1//1KTIloXKi/px4b8oEgcgM3YK9
	OYJtJ34U+sJBMOVQj8cU23dOUBAL7dV/+cyCHb9g5jw9nOkTirmREVC2xk6Nrk8utnA0rQ5me/c
	xNe8OH80IxRYV1IdMonsyaABwMRshLk/hiaWx5y2BlyvBpz1WVDqFCy3IBTmxpxLuDu6wwru8VM
	rcqtIZGqtzLqIGGp94APbW3lZdMxrRbHclrdvVCmj5kREU4ZnH+5P9G7Tx0=
X-Received: by 2002:a05:690e:dc8:b0:664:d71f:4e90 with SMTP id
 956f58d0204a3-6679ed15910mr8999133d50.0.1783692789313; Fri, 10 Jul 2026
 07:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ofono@lists.linux.dev
List-Id: <ofono.lists.linux.dev>
List-Subscribe: <mailto:ofono+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ofono+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
In-Reply-To: <20260710075548.1072741-1-xiuzhuo.shang@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 10 Jul 2026 10:12:54 -0400
X-Gm-Features: AVVi8Ce5oos0eLuIbcU6B1h4zsKYBSdeBo7S6297Ayu89yGHQYwoYByGE3YXZ_0
Message-ID: <CABBYNZJrrQO5XU1yC-HOry1eEaF8fBKV_jK4g3A+qJTAtw0Qqg@mail.gmail.com>
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

On Fri, Jul 10, 2026 at 3:55=E2=80=AFAM Xiuzhuo Shang
<xiuzhuo.shang@oss.qualcomm.com> wrote:
>
> Two related changes to reduce dbus-daemon load caused by high-rate
> BLE advertising signals:
>
> 1. In parse_properties(), skip creating a GDBusProxy for Device1
>    objects whose AddressType is 'random' (BLE-only devices). Each
>    proxy registers a per-device PropertiesChanged watch via
>    g_dbus_add_properties_watch(); with hundreds of BLE peripherals
>    advertising simultaneously, this results in hundreds of match rules
>    and dbus-daemon routing thousands of RSSI PropertiesChanged signals
>    per second to ofono, none of which ofono processes. The
>    AddressType property is available in the InterfacesAdded dict at
>    the time parse_properties() is called, so the check is reliable
>    and race-free.
>
>    BR/EDR devices (AddressType=3D'public') are unaffected: their proxies
>    are created as before, and the property_changed callback continues
>    to receive Paired and ServicesResolved updates needed for HFP/HSP.
>
> 2. In g_dbus_client_new_full(), remove the broad
>    type=3D'signal',sender=3D<service>,path_namespace=3D<path> match rule.
>    This rule was the sole feeder for the signal_func path in
>    message_filter(). ofono never calls g_dbus_client_set_signal_watch()
>    so signal_func is always NULL; the broad rule therefore served no
>    purpose and caused dbus-daemon to route every bluetoothd signal
>    (including all BLE PropertiesChanged) to ofono.
>
>    InterfacesAdded and InterfacesRemoved are already covered by the
>    precise watches registered via g_dbus_add_signal_watch() earlier in
>    g_dbus_client_new_full(), so no functionality is lost.

Looks like this is on ofono though, why are you chaning the BlueZ side?

> Together these two changes prevent dbus-daemon from routing BLE
> advertising PropertiesChanged signals to ofono entirely, eliminating
> the dbus-daemon memory growth and bluetoothd socket backpressure seen
> after hours of BLE scanning.
>
> Signed-off-by: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
> ---
>  gdbus/client.c | 46 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 38 insertions(+), 8 deletions(-)
>
> diff --git a/gdbus/client.c b/gdbus/client.c
> index 48711ae8..dd3c17f9 100644
> --- a/gdbus/client.c
> +++ b/gdbus/client.c
> @@ -937,6 +937,44 @@ static void parse_properties(GDBusClient *client, co=
nst char *path,
>         if (g_str_equal(interface, DBUS_INTERFACE_PROPERTIES) =3D=3D TRUE=
)
>                 return;
>
> +       /*
> +        * Skip BLE devices (AddressType=3D'random') to avoid registering=
 a
> +        * per-device PropertiesChanged watch for every advertising BLE
> +        * peripheral. ofono only needs BR/EDR devices for HFP/HSP; the
> +        * high-rate RSSI PropertiesChanged signals from BLE scanners cau=
se
> +        * dbus-daemon memory bloat and socket backpressure in bluetoothd=
.
> +        *
> +        * The AddressType property is present in the InterfacesAdded dic=
t
> +        * (iter) at this point, so it can be checked before proxy_new().
> +        */
> +       if (g_str_equal(interface, "org.bluez.Device1") =3D=3D TRUE) {
> +               DBusMessageIter props, entry;
> +               DBusMessageIter copy =3D *iter;
> +
> +               if (dbus_message_iter_get_arg_type(&copy) =3D=3D DBUS_TYP=
E_ARRAY) {
> +                       dbus_message_iter_recurse(&copy, &props);
> +                       while (dbus_message_iter_get_arg_type(&props) =3D=
=3D
> +                                               DBUS_TYPE_DICT_ENTRY) {
> +                               const char *key;
> +                               dbus_message_iter_recurse(&props, &entry)=
;
> +                               dbus_message_iter_get_basic(&entry, &key)=
;
> +                               if (g_str_equal(key, "AddressType") =3D=
=3D TRUE) {
> +                                       DBusMessageIter var;
> +                                       const char *addr_type;
> +                                       dbus_message_iter_next(&entry);
> +                                       dbus_message_iter_recurse(&entry,=
 &var);
> +                                       dbus_message_iter_get_basic(&var,
> +                                                               &addr_typ=
e);
> +                                       if (g_str_equal(addr_type,
> +                                                       "random") =3D=3D =
TRUE)
> +                                               return;
> +                                       break;
> +                               }
> +                               dbus_message_iter_next(&props);
> +                       }
> +               }
> +       }

Nack, not going to introduce BlueZ specific logic into gdbus like
this. If we need to rate limit the RSSI notification then it means
it's not suitable to be a property, but I believe we have a threshold
logic in the likes of device_set_rssi_with_delta so perhaps we shall
check why it is not working in your case.

>         proxy =3D proxy_lookup(client, path, interface);
>         if (proxy) {
>                 update_properties(proxy, iter, FALSE);
> @@ -1255,14 +1293,6 @@ GDBusClient *g_dbus_client_new_full(DBusConnection=
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

This perhaps has a merit, but I can't recall what this watch was for.
Is it matching every signal from the sender? It seems it was introduce
before the watch infra existed, so if we can safely remove it we can
perhaps remove the whole client-->match_rules.

>         return g_dbus_client_ref(client);
>  }
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
