Content-Type: multipart/mixed; boundary="===============9149978032539927846=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 18:41:10 -0800
Message-ID: <F9C0146E-49B5-41AA-9697-FB57B9846155@holtmann.org>
In-Reply-To: <5317B676.8040002@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9149978032539927846==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

>>> We've been working on MMS support for Ubuntu Touch recently and have ru=
n into a couple of stumbling blocks, so I have a few questions about the cu=
rrent MMS logic in oFono ( we're still 1.12 based ), and in particular the =
provisioning/management of gprs-contexts.
>>> =

>>> As part of this work, we're planning to switch from using the builtin g=
prs 'provision' plugin, to the new android-provision/apndb plugin ( origina=
lly written by Simon Busch ) which uses the file apns-conf.xml instead of m=
bpi's serviceproviders.xml.
>>> =

>>> There are a couple of issues we ran into...
>>> =

>>> 1. How to represent APNs that support multiple usages types?
>>> =

>>> The "type" attribute in apns-conf.xml is a list vs. the single type def=
ined by a gprs_context.
>>> =

>>> The android-apndb plugin uses TYPE_INTERNET for APNs which support mult=
iple types.  In order to properly support MMS, the core code needed to be m=
odified to allow the MMS properties to be additionally be set on a TYPE_INT=
ERNET context.  Thus if an APN supports both Internet and MMS, our Download=
Manager can grab the additional MMS properties from the context and handle =
MMS traffic.
>>> =

>>> Now perhaps I missed something and there is a way to represent a combin=
ed usage APN ( maybe using TYPE_ANY? ), but I couldn't see how to accomplis=
h without changes to the core gprs code.
>>> =

>>> 2. No way to disable core ofono TYPE_MMS network config.
>>> =

>>> The core gprs_context code has special logic for TYPE_MMS contexts whic=
h configures the HTTP proxy using networking ioctl requests.  We have an ex=
ternal download manager that handles the actual download of content from th=
e message center.  As it has logic to handle HTTP proxies already, if we us=
e TYPE_MMS, we'd need a way to disable ofono's builtin logic.
>> =

>> you do realize that these are not actually standard HTTP proxies. You ar=
e suppose to talk to the MMS Proxy to reach the MMSC. That is how this work=
s. You always go through the MMS Proxy.
> =

> I haven't actually worked directly on the proxy support myself, and had a=
ssumed this was a standard HTTP proxy.  I will make sure my co-worker handl=
ing the support in our download manager realizes this, and point him at mms=
d/connman's GWeb code for reference.
> =

>> If you are mixing Internet proxies with MMS proxies, you end up in a rea=
lly awkward configuration later down the road.
> =

> Sorry, no intentions of mixing them.
> =

>> As Denis mentioned we have been using this successfully within mmsd that=
 we wrote.
> =

> I saw that, we originally did a bunch of work with mmsd, however we decid=
ed instead to add MMS capability to our ubuntu-download-manager used in Tou=
ch.

feels weird if a download manager handles delivery receipts and read receip=
ts. Especially since there are so many MMS specific header in the HTTP requ=
est.

> > The current design of oFono works just fine by activating the
> > MMS context and then talking to the MMS proxy to reach the MMSC.
> =

> Sure, although as I mentioned orginally, if we already have an active dat=
a connection and the apn happens to also support MMS, it seems odd not bein=
g able to share.

If you have an active data connection you can just compare the TYPE_MMS con=
text details (APN, username, passed) with the TYPE_INTERNET context ones an=
d if they match, you choose not to activate the MMS one and just use the In=
ternet one. As I said in the other emails, oFono is activating contexts onl=
y on request. So either ConnMan requests the Internet context or mmsd reque=
sts the MMS context. oFono is not in the business of magically activating c=
ontexts. It only attaches to the GPRS part of the network.

The only problem with the Internet context usage for MMS is that you now al=
so have to talk to ConnMan to figure out when the IP part of the context is=
 successfully configured. And here is where this gets complicated. And acti=
ve context does not mean it is actively in use. You might actually use your=
 WiFi and have an activated Internet context, but neither the IP or routing=
 is set. Or in same case you are just on WiFi and have no Internet context =
activated. As you can see this can get extremely complex.

We opted for just providing a MMS context type and an Internet context type=
. If the APN happens to be the same (not always the case btw.) then you jus=
t double activate that context. Send or receive your MMS and deactivate it.=
 We have used this just fine. And in that case oFono does all the heavy lif=
ting for you. You just need to talk to the MMS Proxy address that has been =
configured. That is it.

Regards

Marcel


--===============9149978032539927846==--

