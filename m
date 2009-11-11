Content-Type: multipart/mixed; boundary="===============0251401011516362340=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Add call volume support for hfpmodem
Date: Tue, 10 Nov 2009 23:52:05 -0600
Message-ID: <200911102352.05641.denkenz@gmail.com>
In-Reply-To: <1257946350.31013.3.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0251401011516362340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> The call volume driver listens the speaker volume and microphone
> gain from the AG. It also allow to synchronze the speaker and
> microphone volume changes with the AG through AT+VGS and AT+VGM.
> +struct cv_data {
> +	GAtChat *chat;
> +	unsigned char cind_pos[HFP_INDICATOR_LAST];

Useless, remove

> +	int cind_val[HFP_INDICATOR_LAST];

Useless, remove

> +	unsigned char sp_volume;
> +	unsigned char mic_volume;
> +};

<snip>

> +static void hfp_call_volume_initialized(gpointer user_data)
> +{
> +	struct ofono_call_volume *cv =3D user_data;
> +	struct cv_data *vd =3D ofono_call_volume_get_data(cv);
> +
> +	DBG("");
> +
> +	g_at_chat_register(vd->chat, "+VGS:", vgs_notify, FALSE, cv, NULL);
> +	g_at_chat_register(vd->chat, "+VGM:", vgm_notify, FALSE, cv, NULL);
> +
> +	ofono_call_volume_register(cv);
> +
> +	ofono_call_volume_set_microphone_volume(cv, vd->mic_volume);
> +	ofono_call_volume_set_speaker_volume(cv, vd->sp_volume);

Section 4.28.2 of HFP Spec.  Don't we need to perform volume level =

synchronization here?

> +}
> +
> +static int hfp_call_volume_probe(struct ofono_call_volume *cv,
> +					unsigned int vendor, void *data)
> +{

<snip>

> +	memcpy(vd->cind_pos, d->cind_pos, HFP_INDICATOR_LAST);
> +	memcpy(vd->cind_val, d->cind_val, HFP_INDICATOR_LAST);

Useless

> +
> +	ofono_call_volume_set_data(cv, vd);
> +
> +	hfp_call_volume_initialized(cv);
> +
> +	return 0;
> +}
> +
> +static void hfp_call_volume_remove(struct ofono_call_volume *cv)
> +{
> +	struct cv_data *vd =3D ofono_call_volume_get_data(cv);

Make sure to ofono_call_volume_set_data(cv, NULL) here.

> +
> +	g_free(vd);
> +}
> +

Regards,
-Denis

--===============0251401011516362340==--

