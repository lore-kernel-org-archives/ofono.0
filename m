Content-Type: multipart/mixed; boundary="===============7499290818523775547=="
MIME-Version: 1.0
From: Matthias =?unknown-8bit?q?G=C3=BCnther?= <matgnt@gmail.com>
Subject: Re: How to start ofono-phonesim in ubuntu-10.04 -reg
Date: Mon, 10 May 2010 16:53:04 +0200
Message-ID: <4BE81DD0.5090109@gmail.com>
In-Reply-To: <COL106-W65AFE01F9875AAF3ED3F84F6F90@phx.gbl>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7499290818523775547==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Krishna.

Your modem.conf is a bit messed up because you've used a wrong one at =

the beginning. According to one of your earlier emails you changed the =

file /usr/share/alsa/pcm/modem.conf which has nothing to do with ofono. =

After moving it to the right place in /etc/ofono/ the content of the =

file is still wrong. So just copy a clean modem.conf out of your ofono =

archive. You can find it there in plugins/modem.conf. Afterwards remove =

the comments for the phonsim block and it should work. With the script =

enable-modem the phonesim-gui should appear.

Regards,
Matthias


On 10.05.2010 15:31, krishna k wrote:
>
> Hi,
>
> After starting ofonod with command "sudo ofonod -n -d", I am getting belo=
w messages
>
> Reading of /etc/ofono/modem.conf failed: Key file contains line 'pcm.!pho=
neline {' which is not a key-value pair, group, or comment
>
> Does it mean that it is not able to recognize the modem presented in mode=
m.conf file?
>
> if i try to execute ./list-modems then it is listing any thing. Please su=
ggest me.
>
> modem.conf file contents
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------
>
> #
> # "raw" modem - phoneline
> #
>
> pcm.!phoneline {
>      @args [ CARD DEV ]
>      @args.CARD {
>          type string
>          default {
>              @func getenv
>              vars [
>                  ALSA_MODEM_CARD
>                  ALSA_PCM_CARD
>                  ALSA_CARD
>              ]
>              default {
>                  @func refer
>                  name defaults.pcm.modem.card
>              }
>          }
>      }
>      @args.DEV {
>          type integer
>          default {
>              @func igetenv
>              vars [
>                  ALSA_MODEM_DEVICE
>              ]
>              default {
>                  @func refer
>                  name defaults.pcm.modem.device
>              }
>          }
>      }
>      @func refer
>      name {
>          @func concat
>          strings [
>              "cards."
>              {
>                  @func card_driver
>                  card $CARD
>              }
>              ".pcm.modem." $DEV ":CARD=3D" $CARD
>          ]
>      }
>      hint.show off
> }
>
> #
> #  "autohooked" modem
> #
>
> pcm.!modem {
>      @args [ CARD DEV ]
>      @args.CARD {
>          type string
>          default {
>              @func getenv
>              vars [
>                  ALSA_MODEM_CARD
>                  ALSA_PCM_CARD
>                  ALSA_CARD
>              ]
>              default {
>                  @func refer
>                  name defaults.pcm.modem.card
>              }
>          }
>      }
>      @args.DEV {
>          type integer
>          default {
>              @func igetenv
>              vars [
>                  ALSA_MODEM_DEVICE
>              ]
>              default {
>                  @func refer
>                  name defaults.pcm.modem.device
>              }
>          }
>      }
>      type hooks
>      slave {
>          pcm {
>              @func concat
>              strings [
>                  "cards.pcm.phoneline:CARD=3D" $CARD ",DEV=3D" $DEV
>              ]
>          }
>      }
>      hooks.0 {
>          type ctl_elems
>          hook_args [
>          {
>              name "Off-hook Switch"
>              preserve true
>              value "on"
>              lock false
>              optional true
>          }
>          ]
>      }
>      hint.show off
> }
>
> #
> #Sample for using phone simulator
> #
> [phonesim]
> Driver=3Dphonesim
> Address=3D127.0.0.1
> port=3D12345
>
> -------------------------------------------------------------------------=
---------------------------------------------------------------------------=
------------------------------
>
> Thanks and Regards,
> Krishna K Kandula
>   		 	   		=

> _________________________________________________________________
> The amazing world in sharp snaps
> http://news.in.msn.com/gallery/archive.aspx
>
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============7499290818523775547==--

