Content-Type: multipart/mixed; boundary="===============8851659448101777049=="
MIME-Version: 1.0
From: Tony Espy <espy@canonical.com>
Subject: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Tue, 04 Mar 2014 19:06:57 -0500
Message-ID: <53166AA1.4060805@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8851659448101777049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

We've been working on MMS support for Ubuntu Touch recently and have run =

into a couple of stumbling blocks, so I have a few questions about the =

current MMS logic in oFono ( we're still 1.12 based ), and in particular =

the provisioning/management of gprs-contexts.

As part of this work, we're planning to switch from using the builtin =

gprs 'provision' plugin, to the new android-provision/apndb plugin ( =

originally written by Simon Busch ) which uses the file apns-conf.xml =

instead of mbpi's serviceproviders.xml.

There are a couple of issues we ran into...

1. How to represent APNs that support multiple usages types?

The "type" attribute in apns-conf.xml is a list vs. the single type =

defined by a gprs_context.

The android-apndb plugin uses TYPE_INTERNET for APNs which support =

multiple types.  In order to properly support MMS, the core code needed =

to be modified to allow the MMS properties to be additionally be set on =

a TYPE_INTERNET context.  Thus if an APN supports both Internet and MMS, =

our DownloadManager can grab the additional MMS properties from the =

context and handle MMS traffic.

Now perhaps I missed something and there is a way to represent a =

combined usage APN ( maybe using TYPE_ANY? ), but I couldn't see how to =

accomplish without changes to the core gprs code.

2. No way to disable core ofono TYPE_MMS network config.

The core gprs_context code has special logic for TYPE_MMS contexts which =

configures the HTTP proxy using networking ioctl requests.  We have an =

external download manager that handles the actual download of content =

from the message center.  As it has logic to handle HTTP proxies =

already, if we use TYPE_MMS, we'd need a way to disable ofono's builtin =

logic.

Would it make sense to add a command-line option to control this behavior?

3. No way to associate additional APN properties with a gprs_context.

apns-conf.xml has many additional APN attributes which don't map =

directly to gprs_context properties ( eg. authtype, mvno_type, ... ).

"types" is especially important, as without it, we can't tell exactly =

which services are supported by the APN ( as the plugin sets the type to =

TYPE_INTERNET ).

So, here's a summary of the changes I made ( again with MMS support as =

one of the main goals ).  Also note, this is WIP, and if there other =

approaches I should consider, I'd appreciate some feedback.

My latest code containing these changes can be found in the following =

github branch.

https://github.com/tonyespy/ofono/tree/mms-new

Note, if it'd be more helpful, I can email the patches directly to the =

list with a "RFC" in the subject line, however I think there's little =

chance that they'd be taken "as is".

1. Modified the core gprs code to allow MMS proxy and message center =

properties to be set on OFONO_GPRS_CONTEXT_TYPE_INTERNET contexts.

2. Modified the android_apndb plugin such that it always creates =

TYPE_INTERNET contexts ( even for standalone MMS APNs, as this allows us =

to bypass the previously mentioned HTTP proxy logic ).

3. Modified the core gprs_context code to allow a new property called =

'ExtraData' to be set during provisioning.  This property is a DBus =

dictionary type ( ie. like 'Setttings' ), and is used by provisioning to =

convey any attributes in apn-confs.xml which don't map directly to ofono =

gprs_contexts.  The current impl doesn't support writes to ExtraData =

from DBus yet.  We may add support to allow a "preferred" attribute ( =

ie. usabe by our Cellular Settings UI ).

If there's a way to accomplish any of these changes via plugins alone, I =

would've gone that route...  Also, if I've missed any other hooks that =

might help us accomplish these changes, I'm welcome to suggestions.

Regards,
/tony







--===============8851659448101777049==--

