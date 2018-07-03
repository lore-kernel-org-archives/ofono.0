Content-Type: multipart/mixed; boundary="===============7324341921751606017=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [qmimodems] gprs context provisioning versus automatically
 discovered contexts in LTE
Date: Tue, 03 Jul 2018 10:53:05 -0500
Message-ID: <1ef3d958-450e-d70f-117c-c287d0c54444@gmail.com>
In-Reply-To: <82d8b6d8-c18e-82fe-9f46-70444c071f71@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7324341921751606017==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 07/03/2018 03:40 AM, Christophe Ronco wrote:
> Hi,
> I am doing a test with a 4G SIM card with APN set in provisionning. I
> 've recently upgraded my Ofono version to 1.23.
> =

> My card gets LTE attach quickly, before it gets ServiceProviderName from
> SIM card.
> So ofono_gprs_cid_activated is called by get_lte_attach_param_cb
> (drivers/qmimodem/gprs.c) and a context is created with APN discovered
> in get_lte_attach_param_cb.
> Then SIM ServiceProviderName is discovered and provision_contexts is
> called. Another context is created with APN from provisioning file.

It would seem that your gprs atom is being created in the post-online =

state.  This means that it doesn't have a chance to run provisioning =

before the network activates a context.  This might be a legacy issue =

because all device drivers initially were written with gprs, =

gprs-context and sim atoms in the post_online state.  However, these =

really should be in post_sim these days, especially for LTE.

> =

> I end up with 2 contexts using same APN or different APNs, depending on
> what I wrote in my provisioning file. I attached logs with same APN case.
> In messages_02.txt:
>  =C2=A0- ofono_gprs_cid_activated is called at line 681
>  =C2=A0- __ofono_gprs_provision_get_settings is called at line 753
> I end up with two contexts (properties summary in gsmdiag_02.txt).
> =

> Another strange thing in ofono gprs file for this SIM card:
> root(a)klk-lpbs-06029C:~ # cat /etc/network/ofono/208013004789734/gprs
> [Settings]
> Powered=3Dtrue
> RoamingAllowed=3Dfalse
> =

> [context1]
> Name=3Dorange-mib
> AccessPointName=3D

I don't really understand how this can happen.  The logic inside =

ofono_gprs_cid_activated should not be setting the context name, only =

the APN.

And I'm pretty sure that provisioning checks that an APN is not empty, =

e.g. is_valid_apn() in provision_context().

So at which point is context1 being created?  Because this looks wrong...

> Username=3D
> Password=3D
> AuthenticationMethod=3Dchap
> Type=3Dinternet
> Protocol=3Dip
> =

> [context2]
> Name=3DInternet
> AccessPointName=3Dorange-mib
> Username=3D
> Password=3D
> AuthenticationMethod=3Dchap
> Type=3Dinternet
> Protocol=3Dip
> =

> Context 1 has no APN. I don't know what would happen if I restart Ofono
> and gets attached on 3G. I don't know if this is a bug or not.

Sounds like it should never be allowed in the first place..

> =

> Here are the "problems" I saw. And I don't know what to do in this case.
> I mean I don't know what result I should have.
> =

> What should happen if context information are the same in provisioning
> and from network discovery? Maybe only one context?
> What should happen if context information are different in provisioning
> and from network discovery? Creation of 2 contexts and 1 gets
> automatically connected? Disconnection of the automatically connected
> context and creation of context using information from provisionning?
> Provisionning ignored?

I think the bottom line is that provisioning should happen before you go =

online and encounter these issues.  ofono_gprs_cid_activated already =

tries to deal with matching the apn, etc.  But it assumes that context =

provisioning has already happened.

What we might need to address is to make the context activated via =

ofono_gprs_cid_activated to be ephemeral.  E.g. if it doesn't match an =

actual context loaded from settings / provisioning, it should not be =

synced to storage and forgotten once we leave LTE.

Regards,
-Denis

--===============7324341921751606017==--

