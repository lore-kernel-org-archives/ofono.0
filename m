Content-Type: multipart/mixed; boundary="===============1176447340681668040=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: ofono plugin
Date: Thu, 03 Nov 2011 15:29:59 +0100
Message-ID: <4EB2A567.7040105@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1176447340681668040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

There was a short discussion on the #ofono channel on the oFono
plugin in ConnMan. As it turns out there are some issues concerning
the way the current plugin interacts with oFono. =


For example the current plugin has a complicated logic how to detect
the modem. It really wants to have a SIM interface before doing anything
else. With the goal to introduce a DUN modem and also the upcoming
CDMA modem support this wont work anymore. There wont be a SIM interface.

The conclusion is the plugin needs a larger overhaul. I have already
started to work on it.

Though I have a few questions on the API. Maybe someone could enlighten me.

There is the Powered property per modem. If that one is set to FALSE,
there is absolutely no way to tell what the modem is unless something
powers it up. Which component should do this? Should ConnMan always
powering up modems in order to go on with the discovering? What happens when
ConnMan finds out that this modem is not interesting. Basically, we
face the situation where there are several modems and different
applications want to take control on a part of the modems(*). We don't have
a global coordinator for this, right?

In modem-api.txt is a TODO on the Interfaces property: "Better to split
this into Status and Capabilities property?". I think that would
make really sense to have this. The code snippet I have written so far
tries to figure exactly this from the Interfaces property (and it looks
ugly because the way the lists can change). The really  nasty thing is,
that unless we set the modem online we just don't know if this modem will
have a ConnectionManager interface and then we can start doing something.

So this brings us back to the initial question. Who is powering the
modems up and sets them online to find out what is supported by the
modem?

BTW, would it make sense to have for example an auto power up feature
in oFono? Having several application trying to enable modems sounds kind
of racy. I also miss the global offline/flightmode switch.

(*)Think about having an HFP modem and an data modem. The HFP modem will
be used only by the dialer app and the data modem only by ConnMan.

cheers,
daniel


<wagi> I have a simple question concerning the dun modem patches
<wagi> I am playing around with them
<wagi> and I like to get connman reconizing the modem
<wagi> this modem exports only the reg and gprs interface
<wagi> unfortunatly the connman plugin is really really depending on having=
 a imsi
<wagi> so the code starts working only if it ind the sim interface
<wagi> It is kind of difficult to know that the modem is a dun modem
<wagi> or at least in the way the plugin is written
<wagi> it is difficult to know what type of modem is there
<wagi> for example it also tries to power up the hfp modem
<denkenz> In theory you know this from the interfaces list
<wagi> even though it has nothing to do with it
<denkenz> if you have the ConnectionManager interface and no Sim, then you =
know its a special modem
<wagi> okay, so the current code tries do to something like this
<wagi> pff, that means I have to rewrite parts of that code
<wagi> damn, why isn't there an easy way :)
<wagi> thanks for the help
<denkenz> Heh, well its not like putting in a sim interface is going to be =
any easier
<denkenz> things might get even more complicated ;)
<wagi> no, that was not my plan. it was more like to know if there is anoth=
er way to guess the special modem stuff
<denkenz> Well, there is the Features thing
<denkenz> But in the end it is the same as peeking at the Interface list
<wagi> yes, that what I see from monitor-ofono
<denkenz> However, you are always guaranteed to have the Sim interface first
<wagi> so I have to create the right filter for the interface list
<denkenz> Due to the nature of pre-sim, post-sim
<wagi> the corresponding code in the plugin looks kind of ugly
<wagi> connman/plugins/ofono.c:modem_changed()
<denkenz> yes, that does look ugly
* Gzajac_ is now known as Gzajac
<wagi> this needs to be made more readable
<wagi> though I don't know how to do it
<denkenz> Why does connman bother with registration btw?
<wagi> I guess it is the signal strength
<wagi> let me check
<wagi> yep signal strength, name, status and mcc
<denkenz> Funny that it isn't triggered as a result of Attached being chang=
ed
<holtmann> denkenz: That is how it should be. I thought we fixed that.
<denkenz> nope, its checking for Netreg interface
<holtmann> Registration was just purely for signal strength.
<denkenz> then running signal/name/mcc query
<holtmann> So it never got fixed.
<holtmann> Right and the network name yes, it needs these, but it should no=
w show up until attached.
<denkenz> exactly, that would make at least that part of the scary nested i=
f-else a bit easier
<holtmann> s/now/not/
<wagi> Do I understand this right: the plugin should listen for Attached cr=
eate a device object and the listens for the intersting Interfaces?
<holtmann> Btw. do we need a fake SIM atom that exposes the BD_ADDR as seri=
al number. Same as with HFP.
<denkenz> Er, sim atom?
<denkenz> No, we don't want to fake the sim atom
<holtmann> The network object should only be created when we are attached. =
Or to be precise it can be created early, but it should only be registered =
when we are attached.
<denkenz> that gets horribly complicated fast
<holtmann> So we might wanna have a Type property in the modem interface to=
 declare some magic modem types.
<denkenz> I don't think this is needed, one can infer the type based on the=
 Interfaces property
<denkenz> e.g. do I have a SIM -> use IMSI, no, use Serial if I have one, o=
therwise use magic random number
<holtmann> But is that really 100% clear all the time. Interfaces can come =
and go.
<denkenz> Sure, but you're guaranteed a sim interface before a connman inte=
rface
<holtmann> Don't we run potentially in a race condition here. Or put too mu=
ch internal logic into some magic interfaces array.
<holtmann> If the modem plugin inside oFono knows what it is (and it does),=
 why not just let us tell that. Instead of trying to come up with some magi=
c rules.
<denkenz> Type isn't really going to help you with that
<holtmann> Why not?
<denkenz> You still have to deal with asyncness of the different interfaces
<denkenz> and you really only care about whether it is a sim based modem or=
 not
<holtmann> For ConnMan, sure that can work.
<holtmann> What about if you wanna know that you are HFP vs real modem.
<denkenz> you'll get the Handsfree interface
<denkenz> then you know
<holtmann> Sounds like a lot of internal logic still.
<holtmann> I am fine either way.
<denkenz> I just don't see what Type gives you besides 'Expect these interf=
aces sometime soon'
<denkenz> And the app has to do that anyway
<wagi> ConnMan should only look for the ConnectionManager API and if it is =
there we do the rest. That should work, right?
<denkenz> basically
<denkenz> You also need to handle no-sim vs sim for cdma as well
<holtmann> It has to look for ConnectionManager and its CDMA version, but y=
es, that should be it.
<holtmann> And before that you need to collect and monitor the other ones s=
ince you need to handle stuff like network name changes etc.
<holtmann> In theory that should be all there. No idea why it is triggered =
by netreg still.
<denkenz> Also, why do we bother running a get_properties on the sim interf=
ace to get the imsi
<denkenz> And then listen to the sim property changed and do the same thing
<holtmann> There is a small race if I remember this correctly. Sometimes th=
e IMSI might come later.
<holtmann> Especically with hotplug of a modem.
<denkenz> oFono always emits SubscriberIdentity =

<holtmann> Check it with monitor-ofono.
<holtmann> I do not remember the details.
* dos1 has quit (Read error: Connection reset by peer)
<denkenz> shouldn't really matter
<denkenz> you won't get the ConnMan interface until SubscriberIdentity has =
been emitted
<holtmann> Maybe it is not a problem anymore, but I remember something ther=
e.
<wagi> that means the ofono plugin needs a major overhaul
* dos1 (~dos(a)unaffiliated/dos1) has joined #ofono
<holtmann> wagi: Tag, you are it ;)
<denkenz> I wouldn't mind remembering why we do it this way
<wagi> and I though you guys are looking for work .)
<denkenz> My gut feeling is that only 1 path is ever invoked
<denkenz> so 1 path is dead code
<holtmann> denkenz: I honestly do not remember. Feel free to dig through th=
e archives.
<holtmann> It could be an oversight in the end.
<wagi> holtmann, if you are okay with it, I create a new plugin something l=
ike ofono-ng.c and when that one is working we can kill the current one.
<denkenz> the get_imsi call is from the original commit from Martin
<denkenz> it sounds like an oversight
<holtmann> wagi: Your only problem will be that both plugins fight against =
each other. So I rather fix the current one.
<holtmann> You can not really make it worse anyway.
<wagi> well, I will break it horrible I guess before it is working
<wagi> so my first patch will be remove all
<wagi> and then a sane series with adding stuff :)
<holtmann> Fine with me.

--===============1176447340681668040==--

