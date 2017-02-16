Content-Type: multipart/mixed; boundary="===============0341843213751296692=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: huawei: modem channel gets closed after PPP disconnection
Date: Thu, 16 Feb 2017 11:51:45 -0600
Message-ID: <522eefa1-acf2-9477-758d-7f4cc73fe92a@gmail.com>
In-Reply-To: <559a763d-d55c-cef6-2832-234196d01099@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0341843213751296692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 02/16/2017 03:26 AM, Christophe Ronco wrote:
> Hi,
>
> I use a huawei E3372 modem. It connects to GPRS using PPP. I am able to
> activate context and then deactivate it. After that, I am not able to
> reactivate the context.
> During deactivation, the AT channel used by PPP gets closed and nobody
> reopens it. During reactivation, the first AT command (AT+CGDCONT) fails.
> Channel shutting down occurs just after NO CARRIER is received on modem
> channel (channel is back to AT state) along with a bunch of wrong data.
> Here is the log:
> Modem: < \r\nNO CARRIER\r\n~\377}#\200!}%}"} }$\210*~
> Shutting down is detected in function received_data (gatio.c). Flags
> G_IO_HUP and G_IO_ERR are received.

This is a common problem with these devices, a hold-over from olden =

serial days.  Basically the modem signals a hangup and in addition to =

sending a NO CARRIER, it also twiddles with some serial status bits. =

This causes the socket to receive a 'shutdown' event.  I think that on =

some devices the serial port is also physically removed for a short =

time, so even opening the port again is likely to fail at least some of =

the time.

We use AT&C0 to turn off this behavior, but it sounds like your firmware =

is ignoring this.

>
> I have done a patch in huawei plugin that correct the problem at least
> with my modem. The idea is for plugin to get notified when modem AT
> channel gets closed and when this happens to remove gprs-context, reopen
> modem AT channel and restart gprs-context driver. This is possible
> because all other drivers (sim, gprs, ...) use PCUI AT channel and not
> modem AT channel.

Doing it in the modem driver (e.g. plugins/huawei.c) is the right place. =

  The fix you have come up with looks okayish.  However, you might want =

to strace/ptrace ofonod to see what the kernel is actually sending you =

to trigger this.  Also, a udev event monitor might help to tell if the =

tty is being physically removed / reinserted.

We have had a similar fix in the past and it simply didn't work due to =

the race conditions outlined.

Regards,
-Denis

--===============0341843213751296692==--

