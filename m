Content-Type: multipart/mixed; boundary="===============6190588055691017156=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 09:57:20 -0800
Message-ID: <B743D34B-64B5-47B8-B480-423D31B0F005@holtmann.org>
In-Reply-To: <53166AA1.4060805@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6190588055691017156==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

> We've been working on MMS support for Ubuntu Touch recently and have run =
into a couple of stumbling blocks, so I have a few questions about the curr=
ent MMS logic in oFono ( we're still 1.12 based ), and in particular the pr=
ovisioning/management of gprs-contexts.
> =

> As part of this work, we're planning to switch from using the builtin gpr=
s 'provision' plugin, to the new android-provision/apndb plugin ( originall=
y written by Simon Busch ) which uses the file apns-conf.xml instead of mbp=
i's serviceproviders.xml.
> =

> There are a couple of issues we ran into...
> =

> 1. How to represent APNs that support multiple usages types?
> =

> The "type" attribute in apns-conf.xml is a list vs. the single type defin=
ed by a gprs_context.
> =

> The android-apndb plugin uses TYPE_INTERNET for APNs which support multip=
le types.  In order to properly support MMS, the core code needed to be mod=
ified to allow the MMS properties to be additionally be set on a TYPE_INTER=
NET context.  Thus if an APN supports both Internet and MMS, our DownloadMa=
nager can grab the additional MMS properties from the context and handle MM=
S traffic.
> =

> Now perhaps I missed something and there is a way to represent a combined=
 usage APN ( maybe using TYPE_ANY? ), but I couldn't see how to accomplish =
without changes to the core gprs code.
> =

> 2. No way to disable core ofono TYPE_MMS network config.
> =

> The core gprs_context code has special logic for TYPE_MMS contexts which =
configures the HTTP proxy using networking ioctl requests.  We have an exte=
rnal download manager that handles the actual download of content from the =
message center.  As it has logic to handle HTTP proxies already, if we use =
TYPE_MMS, we'd need a way to disable ofono's builtin logic.

you do realize that these are not actually standard HTTP proxies. You are s=
uppose to talk to the MMS Proxy to reach the MMSC. That is how this works. =
You always go through the MMS Proxy.

If you are mixing Internet proxies with MMS proxies, you end up in a really=
 awkward configuration later down the road. As Denis mentioned we have been=
 using this successfully within mmsd that we wrote. The current design of o=
Fono works just fine by activating the MMS context and then talking to the =
MMS proxy to reach the MMSC.

Regards

Marcel


--===============6190588055691017156==--

