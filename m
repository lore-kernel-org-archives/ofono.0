Content-Type: multipart/mixed; boundary="===============8882399697094985798=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 01/15] handsfree-audio: Add card driver
Date: Wed, 13 Mar 2013 12:46:40 -0500
Message-ID: <5140BB80.5020905@gmail.com>
In-Reply-To: <5140AF24.1000604@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8882399697094985798==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

>> +struct ofono_handsfree_card_driver {
>> + int (*probe) (struct ofono_handsfree_card *card, void *data);
>> + void (*remove) (struct ofono_handsfree_card *card);
>> + int (*audio_connect) (const char *remote, const char *local);
>> +};
>
> If I understand correctly this will be used by both hfp_hf_bluez5 and
> hfp_ag_bluez5.
> As connection process are not the same for HF and AG roles in HFP 1.6
> handsfree-audio will need a way to discriminate drivers related to each
> of them.
> You may add something like profile UUID to this struct.
>

Why do we need the UUID if we have a driver method?

Regards,
-Denis

--===============8882399697094985798==--

