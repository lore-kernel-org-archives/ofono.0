Content-Type: multipart/mixed; boundary="===============8089446668694251470=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: Re: [qmimodems] gprs context provisioning versus automatically
 discovered contexts in LTE
Date: Thu, 05 Jul 2018 17:31:24 +0200
Message-ID: <81d55883-acdd-8f60-dfcb-f517c72d05c0@kerlink.fr>
In-Reply-To: <1ef3d958-450e-d70f-117c-c287d0c54444@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8089446668694251470==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


On 07/03/2018 05:53 PM, Denis Kenzior wrote:
> Hi Christophe,
>
> On 07/03/2018 03:40 AM, Christophe Ronco wrote:
>> Hi,
>> I am doing a test with a 4G SIM card with APN set in provisionning. I
>> 've recently upgraded my Ofono version to 1.23.
>>
>> My card gets LTE attach quickly, before it gets ServiceProviderName from
>> SIM card.
>> So ofono_gprs_cid_activated is called by get_lte_attach_param_cb
>> (drivers/qmimodem/gprs.c) and a context is created with APN discovered
>> in get_lte_attach_param_cb.
>> Then SIM ServiceProviderName is discovered and provision_contexts is
>> called. Another context is created with APN from provisioning file.
>
> It would seem that your gprs atom is being created in the post-online
> state.=C2=A0 This means that it doesn't have a chance to run provisioning
> before the network activates a context.=C2=A0 This might be a legacy issue
> because all device drivers initially were written with gprs,
> gprs-context and sim atoms in the post_online state.=C2=A0 However, these
> really should be in post_sim these days, especially for LTE.
>
>>
>> I end up with 2 contexts using same APN or different APNs, depending on
>> what I wrote in my provisioning file. I attached logs with same APN
>> case.
>> In messages_02.txt:
>> =C2=A0=C2=A0- ofono_gprs_cid_activated is called at line 681
>> =C2=A0=C2=A0- __ofono_gprs_provision_get_settings is called at line 753
>> I end up with two contexts (properties summary in gsmdiag_02.txt).
>>
>> Another strange thing in ofono gprs file for this SIM card:
>> root(a)klk-lpbs-06029C:~ # cat /etc/network/ofono/208013004789734/gprs
>> [Settings]
>> Powered=3Dtrue
>> RoamingAllowed=3Dfalse
>>
>> [context1]
>> Name=3Dorange-mib
>> AccessPointName=3D
>
> I don't really understand how this can happen.=C2=A0 The logic inside
> ofono_gprs_cid_activated should not be setting the context name, only
> the APN.
>
> And I'm pretty sure that provisioning checks that an APN is not empty,
> e.g. is_valid_apn() in provision_context().
>
> So at which point is context1 being created?=C2=A0 Because this looks wro=
ng...
I fixed this "APN not written in config file" by patch I sent this
morning on the list.
...
>
>>
>> Here are the "problems" I saw. And I don't know what to do in this case.
>> I mean I don't know what result I should have.
>>
>> What should happen if context information are the same in provisioning
>> and from network discovery? Maybe only one context?
>> What should happen if context information are different in provisioning
>> and from network discovery? Creation of 2 contexts and 1 gets
>> automatically connected? Disconnection of the automatically connected
>> context and creation of context using information from provisionning?
>> Provisionning ignored?
>
> I think the bottom line is that provisioning should happen before you
> go online and encounter these issues.=C2=A0 ofono_gprs_cid_activated
> already tries to deal with matching the apn, etc.=C2=A0 But it assumes th=
at
> context provisioning has already happened.
>
> What we might need to address is to make the context activated via
> ofono_gprs_cid_activated to be ephemeral.=C2=A0 E.g. if it doesn't match =
an
> actual context loaded from settings / provisioning, it should not be
> synced to storage and forgotten once we leave LTE.
My modem is a MC7430 and I use gobi plugin. Gprs atom is created in
post-online state in this plugin.
I tried to change that and create gprs atom in post-sim state. Traces
are attached. Code used in gobi plugin:
static void gobi_post_sim(struct ofono_modem *modem)
{
=C2=A0=C2=A0=C2=A0 struct gobi_data *data =3D ofono_modem_get_data(modem);
=C2=A0=C2=A0=C2=A0 struct ofono_gprs *gprs;
=C2=A0=C2=A0=C2=A0 struct ofono_gprs_context *gc;

=C2=A0=C2=A0=C2=A0 DBG("%p", modem);

=C2=A0=C2=A0=C2=A0 ofono_lte_create(modem, "qmimodem", data->device);


=C2=A0=C2=A0=C2=A0 DBG("CRO creating gprs early in gobi_post_sim");
=C2=A0=C2=A0=C2=A0 if (data->features & GOBI_WDS) {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 gprs =3D ofono_gprs_create(modem, 0, =
"qmimodem", data->device);
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 gc =3D ofono_gprs_context_create(mode=
m, 0, "qmimodem",
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 data->device);

=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (gprs && gc)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_gprs_add_con=
text(gprs, gc);
=C2=A0=C2=A0=C2=A0 }

=C2=A0=C2=A0=C2=A0 if (data->features & GOBI_CAT)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_stk_create(modem, 0, "qmimodem"=
, data->device);
=C2=A0=C2=A0=C2=A0 else if (data->features & GOBI_CAT_OLD)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_stk_create(modem, 1, "qmimodem"=
, data->device);

=C2=A0=C2=A0=C2=A0 if (data->features & GOBI_PBM)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_phonebook_create(modem, 0, "qmi=
modem", data->device);

=C2=A0=C2=A0=C2=A0 if (data->features & GOBI_NAS)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_radio_settings_create(modem, 0,=
 "qmimodem", data->device);

=C2=A0=C2=A0=C2=A0 if (data->features & GOBI_WMS)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_sms_create(modem, 0, "qmimodem"=
, data->device);

=C2=A0=C2=A0=C2=A0 if ((data->features & GOBI_WMS) && (data->features & GOB=
I_UIM) &&
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 !ofono_modem_get_b=
oolean(modem, "ForceSimLegacy")) {
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 struct ofono_message_waiting *mw =3D
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0=
 =C2=A0=C2=A0=C2=A0 ofono_message_waiting_create(modem);

=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 if (mw)
=C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 ofono_message_wait=
ing_register(mw);
=C2=A0=C2=A0=C2=A0 }
}


It does not change the problem, ofono_gprs_cid_activated is called
before provisioning occurs.
I think that's because modem is attached immediately after set_online.
Functions called starting from ofono_gprs_create:
1) calling ofono_gprs_cid_activated
ofono_gprs_create (from plugin)
=C2=A0qmi_gprs_probe
=C2=A0 create_nas_cb
create_wds_cb (QMI_NAS_GET_SS_INFO)
ss_info_notify (drivers/qmimodem/gprs.c)
=C2=A0handle_ss_info
=C2=A0 get_lte_attach_params (case REGISTERED + techno=3DLTE)
get_lte_attach_param_cb (WDS, 0x49)
get_default_profile_cb (WDS, 0x85)
get_lte_attach_param_cb
=C2=A0ofono_gprs_cid_activated (line 626 in traces)

2) calling provision_contexts
ofono_gprs_create (from plugin)
=C2=A0qmi_gprs_probe
=C2=A0 create_nas_cb
create_wds_cb
=C2=A0ofono_gprs_register
=C2=A0 ofono_sim_add_spn_watch
=C2=A0=C2=A0 sim_spn_changed
=C2=A0=C2=A0=C2=A0 ofono_sim_read(SIM_EFSPN_FILEID)
sim_spn_read_cb (sim.c)
=C2=A0sim_spn_set
=C2=A0=C2=A0 spn_watches_notify
=C2=A0=C2=A0=C2=A0 spn_read_cb (gprs.c)
=C2=A0=C2=A0=C2=A0=C2=A0 provision_contexts
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __ofono_gprs_provision_get_settings (line 66=
5 in traces)

I am not sure to understand the change you are suggesting. Is it:
provision_contexts checks for contexts already created (via
ofono_gprs_cid_activated). if context corresponds (same APN? same APN,
Username,...?) it does not create a new context and reuse given context

What to do if another context (let's say with a different APN) exist in
provisioning file? Do we close automatically activated context? Do we
remove it? DO we gave priority to automatically activated context?
What do we do if we don't have provisioning file or don't have
provisioning for this SIM operator? Do we continue connection?

--===============8089446668694251470==
Content-Type: application/gzip
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="messages_04.tar.gz"

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
RkZGRkbmw/4CSadi+gAIAgA=
--===============8089446668694251470==--

