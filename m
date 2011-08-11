Content-Type: multipart/mixed; boundary="===============6128576199124593058=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v9 1/4] huaweicdma: create a dedicated netreg atom.
Date: Thu, 11 Aug 2011 00:38:02 -0500
Message-ID: <4E436ABA.2060307@gmail.com>
In-Reply-To: <4E43EF99.3090708@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6128576199124593058==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

This is a gentle reminder not to top-post on this mailing list.

On 08/11/2011 10:04 AM, Philippe Nunes wrote:
> Hi Denis,
> =

> I did a test with a Huawei EC152 cdma dongle in India with this patch.
> Please find below the oFono logs.
> It appears that the service domain is reported in the ^SYSINFO answer as
> 'CDMA not supported' whereas the cdma data connection could be
> established successfully.
> =

> ofonod[11013]: Modem: > AT^SYSINFO\r
> ofonod[11013]: Modem: < \r\n^SYSINFO:0,255,0,0,0\r\n\r\nOK\r\n
> ofonod[11013]:
> drivers/huaweicdmamodem/network-registration.c:sysinfo_cb() 0, 255, 0

If you're getting to this point then it isn't related to the refactoring
I've done.

> =

> The issue is that the switch case in the function 'parse_sysinfo' is
> overiding the status returned by the field srv_status by the status
> returned by the field srv_domain. Therefore, the status returned by the
> function 'parse_sysinfo' is always
> "CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED'.
> =

> In practice, I don't think we need to handle the srv_domain field.
> Perhaps, do you have some background here you can share?
> =


Bertrand or Guillaume might be better suited to answer this question.

> I need also to raise another issue which is more likely a timing issue.
> Until now, the cdma connection could be initiated as soon as the
> cdma.ConnectionManager interface was registered in ofono.org.
> For cdma, as only few AT commands are exchanged, this can happen quite
> immediately and is likely to fail since we are not registered to the
> network.
> Now that the cdma netreg atom is available, could we think indeed to
> register ConMann to the cdma netreg status change but also to trigger
> the cdma cellular network creation once the status becomes 'registered'?
> That said, I don't know if this status is sufficiently representative
> like the 'Attached' state for gprs.

We should not succeed in setting Powered=3DTrue unless the cdma_netreg
atom has indicated it is registered to a network.

> =

> For gprs precisely, can we think to adopt the same mechanism ? I mean,
> add the cellular networks (corresponding to the gprs contexts) only once
> gprs is attached ? This could be helpful in case of automatic
> reconnection after plug-in the 3G dongle (it avoids to perform the
> automatic connection too early).
> =


I'm confused, gprs?  Are you talking about CDMA or GSM?  There are no
contexts in CDMA, this is why the API looks the way it does.

For CDMA, ConnMan should handle automatic reconnection, it is up to the
ofono plugin in ConnMan to do the right thing (e.g. listen to
cdma_netreg state changes and attempt setting Powered then)

Regards,
-Denis

--===============6128576199124593058==--

