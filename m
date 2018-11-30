Content-Type: multipart/mixed; boundary="===============1293927130038638009=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/3] coex: coex agent implementation
Date: Fri, 30 Nov 2018 21:10:18 +0100
Message-ID: <20181130201018.GA2704@amd>
In-Reply-To: <1543570976-20522-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1293927130038638009==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> +	dbus_message_iter_init_append(reply, &iter);
> +
> +	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
> +					OFONO_PROPERTIES_ARRAY_SIGNATURE,
> +					&dict);
> +
> +	value =3D coex->bt_active;
> +	ofono_dbus_dict_append(&dict, "BTActive",
> +								DBUS_TYPE_BOOLEAN, &value);
> +
> +	value =3D coex->wlan_active;
> +	ofono_dbus_dict_append(&dict, "WLANActive",
> +								DBUS_TYPE_BOOLEAN, &value);
> +
> +	band =3D ofono_wlan_bw_to_string(coex->wlan_bw);
> +	ofono_dbus_dict_append(&dict, "WLANBandwidth",
> +									DBUS_TYPE_STRING, &band);


Something wrong with tabs here?

> +	if (coex->bt_active !=3D coex->pending_bt_active) {
> +		coex->bt_active =3D coex->pending_bt_active;
> +		ofono_dbus_signal_property_changed(conn, path,
> +						OFONO_COEX_INTERFACE,
> +						"BTActive",
> +						DBUS_TYPE_BOOLEAN,
> +						&(coex->bt_active));
> +	}

Could probably be reformatted to fit on less lines.

> +	g_at_result_iter_init(&iter, result);
> +
> +	if (!g_at_result_iter_next(&iter, "+XNRTCWSW:"))
> +		return;
> +
> +	g_at_result_iter_next_number(&iter, &wlan.safe_rx_min);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_next_number(&iter, &wlan.safe_rx_max);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_next_number(&iter, &wlan.safe_tx_min);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_next_number(&iter, &wlan.safe_tx_max);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_skip_next(&iter);
> +
> +	g_at_result_iter_next_number(&iter, &wlan.num_safe_vector);

Making every second line empty does not really help readability...

									Pavel
									=

-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============1293927130038638009==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsd0JtU29BQ2drUU1PZndhcFhiK3ZJZ0p3Q2dsNVR6R1lGeVRMdU5zbXRBb2lvSEUyQ1kK
QWhzQW4xc1pPL1hTNHJ6ME5SYzF5dk5YQ2RKeVdPdzcKPWtjU2IKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1293927130038638009==--

