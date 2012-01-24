Content-Type: multipart/mixed; boundary="===============1524242595167982317=="
MIME-Version: 1.0
From: Jussi Kukkonen <jussi.kukkonen@intel.com>
Subject: Re: create_modem/destroy_modem() loop with Huawei USB modem
Date: Wed, 25 Jan 2012 00:31:14 +0200
Message-ID: <CAHiDW_GiyFxQeF0F=9yiTzDfofRGKdAdmRo2bUGiGJOiOAY2JA@mail.gmail.com>
In-Reply-To: <CAHiDW_FQyQqiORS3jjvNTP7z+fUWdWOd9F9gZtCf4_a2BqC5Ag@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1524242595167982317==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 4, 2012 at 2:30 PM, Jussi Kukkonen <jussi.kukkonen@intel.com>=
 wrote:
> I'm sometimes seeing a create_modem/destroy_modem() loop that seems to
> go on forever: Maybe half an hour ago I inserted a USB modem and tried
> to "test/enable-modem" (although I think enable-modem is not needed to
> trigger it). Now the Modem objects keep appearing and disappearing on
> the system bus: It's currently at "/huawei189" and counting.
>
> The device is a Huawei E1550, connected straight to a laptop USB port.
> This has happened maybe five times altogether but it's not easily
> reproducable. I have my own ofono client running but it doesn't really
> do anything other than attach to Manager and Modem signals (and do the
> corresponding initial GetModems()/GetProperties() method calls).

This has just started happening a lot (as in 100% for last 20 minutes)
for an unknown reason -- this stress test was possibly how I found the
crash I reported a few minutes ago... anyway, to be able to test other
bugs I had to investigate this further: turns out this is probably not
a ofono problem, but I would appreciate any help from this list.

I'm seeing this happen constantly, over and over, even if ofonod is
not running (as long as I've run it once to do the modeswitch) :

Jan 25 00:13:28 loki kernel: [  560.421045] usb 1-1.1: reset
high-speed USB device number 66 using ehci_hcd
Jan 25 00:13:28 loki kernel: [  560.518464] option 1-1.1:1.3: GSM
modem (1-port) converter detected
Jan 25 00:13:28 loki kernel: [  560.518619] usb 1-1.1: GSM modem
(1-port) converter now attached to ttyUSB0
Jan 25 00:13:28 loki kernel: [  560.518769] option 1-1.1:1.2: GSM
modem (1-port) converter detected
Jan 25 00:13:28 loki kernel: [  560.519447] usb 1-1.1: GSM modem
(1-port) converter now attached to ttyUSB1
Jan 25 00:13:28 loki kernel: [  560.520149] option 1-1.1:1.1: GSM
modem (1-port) converter detected
Jan 25 00:13:28 loki kernel: [  560.520321] usb 1-1.1: GSM modem
(1-port) converter now attached to ttyUSB2
Jan 25 00:13:28 loki kernel: [  560.520440] option 1-1.1:1.0: GSM
modem (1-port) converter detected
Jan 25 00:13:28 loki kernel: [  560.520584] usb 1-1.1: GSM modem
(1-port) converter now attached to ttyUSB3
Jan 25 00:13:28 loki kernel: [  560.542530] option1 ttyUSB3: GSM modem
(1-port) converter now disconnected from ttyUSB3
Jan 25 00:13:28 loki kernel: [  560.542548] option 1-1.1:1.0: device
disconnected
Jan 25 00:13:28 loki kernel: [  560.542766] option1 ttyUSB2: GSM modem
(1-port) converter now disconnected from ttyUSB2
Jan 25 00:13:28 loki kernel: [  560.542783] option 1-1.1:1.1: device
disconnected
Jan 25 00:13:28 loki kernel: [  560.543132] option1 ttyUSB1: GSM modem
(1-port) converter now disconnected from ttyUSB1
Jan 25 00:13:28 loki kernel: [  560.543149] option 1-1.1:1.2: device
disconnected
Jan 25 00:13:28 loki kernel: [  560.543204] option1 ttyUSB0: GSM modem
(1-port) converter now disconnected from ttyUSB0
Jan 25 00:13:28 loki kernel: [  560.543219] option 1-1.1:1.3: device
disconnected

Any hints to what this might and and how I can avoid it are welcome.

 - Jussi

--===============1524242595167982317==--

