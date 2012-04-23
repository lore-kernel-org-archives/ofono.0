Content-Type: multipart/mixed; boundary="===============8524886327082849858=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC v4 10/10] emulator: Update supported features
Date: Sun, 22 Apr 2012 19:03:58 -0500
Message-ID: <4F949C6E.90102@gmail.com>
In-Reply-To: <4F9560B8.3090708@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8524886327082849858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

>> I think it would be better for the features to be modified based on what
>> command handlers are registered.  E.g. if NREC handler is registered in
>> ofono_emulator_add_handler then add ECNR to local features, etc.
> =

> Local features are sent during reply to AT+BRSF command (after emulator
> creation and command handlers registration), but also in the Bluetooth
> SDP record, before client connection (so before emulator creation).
> =


Fair enough, however the SDP record is not a 1:1 mapping to BRSF, only a
subset is covered.

> Imho, local features value should only be created in hfp_ag.c file, and
> passed to the emulator through ofono_emulator_create() or a new
> ofono_emulator_set_features() API.

The thing is that the plugin has no knowledge of whether 3WAY, enhanced
call status, enhanced call control, etc are supported.  Right now these
are hard-coded, but they might depend on driver / technology.  So at
best the emulator_create would be a mask to be ORed onto the local
features set from the core.

In the end I'm fine either way, but it might be easier to avoid the
extra step in the plugin if the core can do this easily just based on
the command handlers being registered.

Regards,
-Denis

--===============8524886327082849858==--

