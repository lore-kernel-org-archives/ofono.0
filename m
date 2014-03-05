Content-Type: multipart/mixed; boundary="===============4139806891972354512=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Wed, 05 Mar 2014 18:42:46 -0500
Message-ID: <5317B676.8040002@canonical.com>
In-Reply-To: <B743D34B-64B5-47B8-B480-423D31B0F005@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4139806891972354512==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/05/2014 12:57 PM, Marcel Holtmann wrote:
> Hi Tony,
>
>> We've been working on MMS support for Ubuntu Touch recently and have run=
 into a couple of stumbling blocks, so I have a few questions about the cur=
rent MMS logic in oFono ( we're still 1.12 based ), and in particular the p=
rovisioning/management of gprs-contexts.
>>
>> As part of this work, we're planning to switch from using the builtin gp=
rs 'provision' plugin, to the new android-provision/apndb plugin ( original=
ly written by Simon Busch ) which uses the file apns-conf.xml instead of mb=
pi's serviceproviders.xml.
>>
>> There are a couple of issues we ran into...
>>
>> 1. How to represent APNs that support multiple usages types?
>>
>> The "type" attribute in apns-conf.xml is a list vs. the single type defi=
ned by a gprs_context.
>>
>> The android-apndb plugin uses TYPE_INTERNET for APNs which support multi=
ple types.  In order to properly support MMS, the core code needed to be mo=
dified to allow the MMS properties to be additionally be set on a TYPE_INTE=
RNET context.  Thus if an APN supports both Internet and MMS, our DownloadM=
anager can grab the additional MMS properties from the context and handle M=
MS traffic.
>>
>> Now perhaps I missed something and there is a way to represent a combine=
d usage APN ( maybe using TYPE_ANY? ), but I couldn't see how to accomplish=
 without changes to the core gprs code.
>>
>> 2. No way to disable core ofono TYPE_MMS network config.
>>
>> The core gprs_context code has special logic for TYPE_MMS contexts which=
 configures the HTTP proxy using networking ioctl requests.  We have an ext=
ernal download manager that handles the actual download of content from the=
 message center.  As it has logic to handle HTTP proxies already, if we use=
 TYPE_MMS, we'd need a way to disable ofono's builtin logic.
>
> you do realize that these are not actually standard HTTP proxies. You are=
 suppose to talk to the MMS Proxy to reach the MMSC. That is how this works=
. You always go through the MMS Proxy.

I haven't actually worked directly on the proxy support myself, and had =

assumed this was a standard HTTP proxy.  I will make sure my co-worker =

handling the support in our download manager realizes this, and point =

him at mmsd/connman's GWeb code for reference.

> If you are mixing Internet proxies with MMS proxies, you end up in a real=
ly awkward configuration later down the road.

Sorry, no intentions of mixing them.

> As Denis mentioned we have been using this successfully within mmsd that =
we wrote.

I saw that, we originally did a bunch of work with mmsd, however we =

decided instead to add MMS capability to our ubuntu-download-manager =

used in Touch.

 > The current design of oFono works just fine by activating the
 > MMS context and then talking to the MMS proxy to reach the MMSC.

Sure, although as I mentioned orginally, if we already have an active =

data connection and the apn happens to also support MMS, it seems odd =

not being able to share.

Thanks for jumping in, it's been awhile.  ;)

Regards,
/tony


--===============4139806891972354512==--

