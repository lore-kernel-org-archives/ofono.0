Content-Type: multipart/mixed; boundary="===============3849770890094509834=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH v0 01/15] handsfree-audio: Add card driver
Date: Thu, 14 Mar 2013 10:59:56 +0100
Message-ID: <51419F9C.5080001@linux.intel.com>
In-Reply-To: <5140BB80.5020905@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3849770890094509834==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis,

On 13/03/2013 18:46, Denis Kenzior wrote:
> Hi Fred,
>
>>> +struct ofono_handsfree_card_driver {
>>> + int (*probe) (struct ofono_handsfree_card *card, void *data);
>>> + void (*remove) (struct ofono_handsfree_card *card);
>>> + int (*audio_connect) (const char *remote, const char *local);
>>> +};
>>
>> If I understand correctly this will be used by both hfp_hf_bluez5 and
>> hfp_ag_bluez5.
>> As connection process are not the same for HF and AG roles in HFP 1.6
>> handsfree-audio will need a way to discriminate drivers related to each
>> of them.
>> You may add something like profile UUID to this struct.
>>
>
> Why do we need the UUID if we have a driver method?

AFAIU, both HFP plugins (hfp_hf_bluez5 and hfp_ag_bluez5) will register =

a card driver.
With this patches, when ofono_handsfree_card_create() is called it links =

the first registered driver to the ofono_handsfree_card. I.e., if HFP AG =

card driver is registered before HFP HF one, it will use the driver =

connection method of HFP HF.

Plus, as you know, audio connection in HFP 1.6 is not the same for HF =

and AG roles.

This is why I think we need a way to distinguish card drivers of HFP HF =

and HFP AG.
I think we can do this by adding UUID to ofono_handsfree_card_driver or =

to probe function (so passing it to ofono_handsfree_card_create).

Did I miss something ?

Regards

Fred


-- =

Frederic Danis                            Open Source Technology Center
frederic.danis(a)intel.com                              Intel Corporation


--===============3849770890094509834==--

