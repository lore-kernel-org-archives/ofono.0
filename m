Content-Type: multipart/mixed; boundary="===============6082221496728235971=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: RFC: Ubuntu Touch, MMS, and Provisioning
Date: Tue, 04 Mar 2014 21:13:30 -0600
Message-ID: <5316965A.5070902@gmail.com>
In-Reply-To: <53166AA1.4060805@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6082221496728235971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

 > Now perhaps I missed something and there is a way to represent a
> combined usage APN ( maybe using TYPE_ANY? ), but I couldn't see how to
> accomplish without changes to the core gprs code.

oFono is not designed to handle combined usage APNs.  If the APN for MMS =

and Internet is the same, we would simply 'double-activate' the same APN =

using multiple contexts. e.g. you would have an Internet context and an =

MMS context with the same APN.  This of course requires your underlying =

modem driver to be able to use multiple contexts simultaneously (e.g. =

multiple gprs_context atoms present.)

If you want to go through the trouble of adding hybrid behavior, then =

patches are welcome.

>
> 2. No way to disable core ofono TYPE_MMS network config.
>
> The core gprs_context code has special logic for TYPE_MMS contexts which
> configures the HTTP proxy using networking ioctl requests.  We have an
> external download manager that handles the actual download of content
> from the message center.  As it has logic to handle HTTP proxies
> already, if we use TYPE_MMS, we'd need a way to disable ofono's builtin
> logic.
>
> Would it make sense to add a command-line option to control this behavior?

oFono only sets up a route and runs the equivalent of ifconfig.  It =

doesn't do any proxying.  This logic is there because ConnMan explicitly =

ignores contexts of type=3Dmms.  So someone must take care of bringing up =

the interface, assigning IP, etc.

You might also want to check out the mmsd project since that already =

works with oFono.

>
> 3. No way to associate additional APN properties with a gprs_context.
>
> apns-conf.xml has many additional APN attributes which don't map
> directly to gprs_context properties ( eg. authtype, mvno_type, ... ).
>

If you have usecases in mind for some of these properties, feel free to =

suggest extensions to the oFono API.

> "types" is especially important, as without it, we can't tell exactly
> which services are supported by the APN ( as the plugin sets the type to
> TYPE_INTERNET ).

As mentioned above, you'd simply create multiple contexts with the same =

APN and different types if you wanted to accomplish this easily.

Regards,
-Denis

--===============6082221496728235971==--

