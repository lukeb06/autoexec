local a={cache={}::any}do do local function __modImpl()local c,d,e,b=true,false,{}function e.set_manual(f)d=f end function e.get_manual()return d end function e
.enable()if d then return end local f,g=game:GetService'Players'.LocalPlayer,game:GetService'RunService'c=false task.wait(0.1)local function NoclipLoop()if c==
false and f.Character~=nil then for h,i in pairs(f.Character:GetDescendants())do if i:IsA'BasePart'and i.CanCollide==true then local j=i:FindFirstChild
'CouldCollide'if not j then local k=Instance.new'BoolValue'k.Name='CouldCollide'k.Value=i.CanCollide k.Parent=i end i.CanCollide=false end if i:IsA'BasePart'and
i.Transparency~=1 and i.Transparency~=0.5 then local j=Instance.new'NumberValue'j.Name='Transparency'j.Value=i.Transparency j.Parent=i i.Transparency=0.5 end
end end end b=g.Stepped:Connect(NoclipLoop)end function e.disable()if d then return end if b then b:Disconnect()local f=game:GetService'Players'.LocalPlayer for
g,h in pairs(f.Character:GetDescendants())do if h:IsA'BasePart'then local i=h:FindFirstChild'CouldCollide'if i then h.CanCollide=i.Value i:Destroy()end local j=
h:FindFirstChild'Transparency'if j then h.Transparency=j.Value j:Destroy()end end end end c=true end function e.toggleNoclip()if c then e.enable()else e.
disable()end end return e end function a.a():typeof(__modImpl())local b=a.cache.a if not b then b={c=__modImpl()}a.cache.a=b end return b.c end end do local 
function __modImpl()local b={}b.target=nil b.locked=false function b.findTarget()local c=game:GetService'Players'.LocalPlayer local d,e,f=c and c.Character,c
and c:GetMouse(),workspace.CurrentCamera local g,h=f:ScreenPointToRay(e.X,e.Y),RaycastParams.new()h.FilterDescendantsInstances={d}h.FilterType=Enum.
RaycastFilterType.Exclude local i=workspace:Raycast(g.Origin,g.Direction*500,h)if i and i.Instance then local j=i.Instance:FindFirstAncestorOfClass'Model'if j
and j:FindFirstChild'Humanoid'and j~=d then return j end end local k,j=math.huge for l,m in game:GetService'Players':GetPlayers()do if m~=c and m.Character and
m.Character:FindFirstChild'Head'then local n=m.Character.Head local o,p=f:WorldToViewportPoint(n.Position)if p then local q=(Vector2.new(o.X,o.Y)-Vector2.new(e.
X,e.Y)).Magnitude if q<k then k=q j=m.Character end end end end return j end function b.toggleLock()b.locked=not b.locked if b.locked then local c=b.findTarget(
)if c then b.target=c:WaitForChild'Head'else b.locked=false end else b.target=nil end end game:GetService'RunService'.RenderStepped:Connect(function()if b.
locked and b.target and b.target.Parent then local c=workspace.CurrentCamera c.CFrame=CFrame.new(c.CFrame.Position,b.target.Position)end end)return b end
function a.b():typeof(__modImpl())local b=a.cache.b if not b then b={c=__modImpl()}a.cache.b=b end return b.c end end do local function __modImpl()local b,c,d=a
.a(),a.b(),{}function d.WaitForGameAndPlayer()local e,f=false,false while not(e and f)do if game:IsLoaded()then e=true end if game:GetService'Players'.
LocalPlayer then f=true end task.wait()end end function d.diff3d(e,f)return f-e end function d.dist3d(e,f)return d.diff3d(e,f).Magnitude end function d.dir3d(e,
f)return d.diff3d(e,f).Unit end function d.isDev()local e,f='pathwise',game:GetService'Players'.LocalPlayer if string.sub(f.Name,1,#e)==e then return true end
return false end function d.isKBM()local e=game:GetService'UserInputService'return e.KeyboardEnabled and e.MouseEnabled end d.Noclip=b d.Aimlock=c function d.
breakVelocity(e)task.spawn(function()local f,g,h=game:GetService'Players'.LocalPlayer,false,Vector3.new(0,0,0)task.spawn(function()task.wait(e)g=true end)while
not g do for i,j in ipairs(f.Character:GetDescendants())do if j:IsA'BasePart'then j.Velocity,j.RotVelocity=h,h end end task.wait()end end)end local e,f=20,false
function d.get_safeTweening()return f end function d.set_safeTweening(g)f=g end function d.set_safeTweenSpeed(g)e=g end function d.safeTweenToPos(g)local h,i=
game:GetService'TweenService',game:GetService'Players'.LocalPlayer local j=i and i.Character local k,l=j and j:FindFirstChild'HumanoidRootPart',j and j:
FindFirstChildOfClass'Humanoid'local m=d.dist3d(k.Position,g.Position)local n=m/e f=true if l and l.SeatPart then l.Sit=false task.wait(0.1)end task.wait(0.1)h:
Create(k,TweenInfo.new(n,Enum.EasingStyle.Linear),{CFrame=g}):Play()task.delay(n,function()f=false end)d.breakVelocity(n)end function d.safeTweenToPart(g,h)if g
:IsA'BasePart'then local i=game:GetService'Players'.LocalPlayer local j=i and i.Character local k,l=j and j:FindFirstChild'HumanoidRootPart',j and j:
FindFirstChildWhichIsA'Humanoid'f=true if l and l.SeatPart then l.Sit=false task.wait(0.1)end local m d.Noclip.enable()game.Workspace.Gravity=0 m=game:
GetService'RunService'.Heartbeat:Connect(function(n)d.breakVelocity(0.1)if not k or not g or not g.Parent or(h and h(g))then m:Disconnect()f=false d.Noclip.
disable()game.Workspace.Gravity=196.21 if l then l:ChangeState(Enum.HumanoidStateType.GettingUp)end return end local o,p=k.Position,g.Position local q,r=d.
dist3d(o,p),e*n if q<=r then k.CFrame=g.CFrame m:Disconnect()f=false d.Noclip.disable()if l then l:ChangeState(Enum.HumanoidStateType.GettingUp)end game.
Workspace.Gravity=196.21 else local s=d.dir3d(o,p)local t=o+(s*r)if l then l:ChangeState(Enum.HumanoidStateType.Physics)end k.CFrame=CFrame.new(t)*(g.CFrame-g.
CFrame.Position)end end)end end function d.flingCharacter(g)local h=game:GetService'Players'.LocalPlayer local i=h and h.Character local j,k=i and i:
FindFirstChild'HumanoidRootPart',g and g:FindFirstChild'HumanoidRootPart'if j and k then d.Noclip.enable()task.wait(0.2)local l=j.CFrame task.wait(0.1)for m,n
in pairs(i:GetDescendants())do if n:IsA'BasePart'then n.CustomPhysicalProperties=PhysicalProperties.new(100,0.3,0.5)end end for m,n in i:GetChildren()do if n:
IsA'BasePart'then n.CanCollide=false n.Massless=true n.Velocity=Vector3.new(0,0,0)end end local m=99999 local n,o=m o=game:GetService'RunService'.Heartbeat:
Connect(function(p)if not k or not k.Parent then return end local q,r=math.random(-100,100),k.AssemblyLinearVelocity if r.Magnitude>500 then o:Disconnect()end
local s=k.Position+(r*0.08)if s.Y<=game.Workspace.FallenPartsDestroyHeight+50 then return end j.CFrame=(CFrame.new(s+Vector3.new(0.1,0,0.1)))*(j.CFrame-j.CFrame
.Position)j.AssemblyLinearVelocity=Vector3.new(m+q,-100,m+q)j.AssemblyAngularVelocity=Vector3.new(0,n,0)end)task.spawn(function()while o.Connected do n=m task.
wait(0.2)n=0 task.wait(0.1)end end)task.delay(3,function()for p,q in pairs(i:GetDescendants())do if q.ClassName=='Part'or q.ClassName=='MeshPart'then q.
CustomPhysicalProperties=PhysicalProperties.new(0.7,0.3,0.5)end end d.Noclip.disable()o:Disconnect()d.breakVelocity(0.2)task.wait(0.1)j.CFrame=l end)end end
function d.flingPlayer(g)local h=g and g.Character d.flingCharacter(h)end function d.isFriendsWith(g)local h=game:GetService'Players'.LocalPlayer return h:
IsFriendsWith(g.UserId)end function d.updateESP(g,h,i)local j=g:FindFirstChild'ESPHL'if j then if not i then j:Destroy()elseif h~=j.FillColor then j.FillColor=h
j.OutlineColor=h end elseif i then local k=Instance.new'Highlight'k.Name='ESPHL'k.Adornee=g k.FillColor=h k.OutlineColor=h k.Parent=g end end d.esp_players={}d.
esp_show_names=false d.esp_show_health=false function d.updatePlayerESP(g,h,i,j)local k=g and g.Character local l=k and k:FindFirstChildWhichIsA'Humanoid'local
m,n=l and l.Health>0,(d.isFriendsWith(g)and(j or h))or h d.esp_players[g]={enabled=i and m,color=n}if k then d.updateESP(k,n,i and m)end end task.spawn(function
()local g=Instance.new('Folder',game.CoreGui)while task.wait()do if d.esp_show_names or d.esp_show_health then if not g or not g.Parent then g=Instance.new(
'Folder',game.CoreGui)end for h,i in pairs(d.esp_players)do local j,k,l=i.enabled,i.color,g:FindFirstChild(h.Name..'_ESP')local function getHealth()local m=h
and h.Character local n=m and m:FindFirstChildWhichIsA'Humanoid'if n then local o=n.Health/n.MaxHealth local p,q=math.floor(o*100),Color3.fromHSV(o*(
0.2777777777777778),0.8,0.8)return{health=p,color=q}else return{health=0,color=Color3.fromRGB(0,0,0)}end end if j then local m=h and h.Character local n=m and m
:FindFirstChild'Head'if not l then if n then local o=Instance.new('Folder',g)o.Name=h.Name..'_ESP'local p=Instance.new('BillboardGui',o)local q,r=Instance.new(
'TextLabel',p),Instance.new('TextLabel',p)p.Adornee=n p.Size=UDim2.new(0,100,0,40)p.StudsOffset=Vector3.new(0,2,0)p.AlwaysOnTop=true q.Name='NameLabel'q.
BackgroundTransparency=1 q.Position=UDim2.new(0,0,0,0)q.Size=UDim2.new(0,100,0,20)q.Font=Enum.Font.SourceSansSemibold q.TextSize=20 q.TextColor3=k q.
TextStrokeTransparency=0 q.TextStrokeColor3=Color3.new(0,0,0)q.TextYAlignment=Enum.TextYAlignment.Bottom q.Text=''q.ZIndex=10 r.Name='HealthLabel'r.
BackgroundTransparency=1 r.Position=UDim2.new(0,0,0,20)r.Size=UDim2.new(0,100,0,20)r.Font=Enum.Font.SourceSansSemibold r.TextSize=20 r.TextColor3=k r.
TextStrokeTransparency=0 r.TextStrokeColor3=Color3.new(0,0,0)r.TextYAlignment=Enum.TextYAlignment.Bottom r.Text=''r.ZIndex=10 end else local o=l:FindFirstChild
'BillboardGui'if o and n then o.Adornee=n local p=o:FindFirstChild'NameLabel'if p then if d.esp_show_names then p.Text=h.Name p.TextColor3=k else p.Text=''end
end local q=o:FindFirstChild'HealthLabel'if q then if d.esp_show_health then local r=getHealth()local s,t=r.health,r.color q.Text=s..'%'q.TextColor3=t else q.
Text=''end end end end else if l then l:Destroy()end end end else g:Destroy()end end end)function d.getLocalPlayer()return game:GetService'Players'.LocalPlayer
end function d.getLocalChar()local g=d.getLocalPlayer()return g and g.Character end function d.getLocalRoot()local g=d.getLocalChar()return g and g:
FindFirstChild'HumanoidRootPart'end function d.getLocalHumanoid()local g=d.getLocalChar()return g and g:FindFirstChildWhichIsA'Humanoid'end return d end
function a.c():typeof(__modImpl())local b=a.cache.c if not b then b={c=__modImpl()}a.cache.c=b end return b.c end end do local function __modImpl()local b={
Default={TextColor=Color3.fromRGB(240,240,240),Background=Color3.fromRGB(25,25,25),Topbar=Color3.fromRGB(34,34,34),Shadow=Color3.fromRGB(20,20,20),
NotificationBackground=Color3.fromRGB(20,20,20),NotificationActionsBackground=Color3.fromRGB(230,230,230),TabBackground=Color3.fromRGB(80,80,80),TabStroke=
Color3.fromRGB(85,85,85),TabBackgroundSelected=Color3.fromRGB(210,210,210),TabTextColor=Color3.fromRGB(240,240,240),SelectedTabTextColor=Color3.fromRGB(50,50,50
),ElementBackground=Color3.fromRGB(35,35,35),ElementBackgroundHover=Color3.fromRGB(40,40,40),SecondaryElementBackground=Color3.fromRGB(25,25,25),ElementStroke=
Color3.fromRGB(50,50,50),SecondaryElementStroke=Color3.fromRGB(40,40,40),SliderBackground=Color3.fromRGB(50,138,220),SliderProgress=Color3.fromRGB(50,138,220),
SliderStroke=Color3.fromRGB(58,163,255),ToggleBackground=Color3.fromRGB(30,30,30),ToggleEnabled=Color3.fromRGB(0,146,214),ToggleDisabled=Color3.fromRGB(100,100,
100),ToggleEnabledStroke=Color3.fromRGB(0,170,255),ToggleDisabledStroke=Color3.fromRGB(125,125,125),ToggleEnabledOuterStroke=Color3.fromRGB(100,100,100),
ToggleDisabledOuterStroke=Color3.fromRGB(65,65,65),DropdownSelected=Color3.fromRGB(40,40,40),DropdownUnselected=Color3.fromRGB(30,30,30),InputBackground=Color3.
fromRGB(30,30,30),InputStroke=Color3.fromRGB(65,65,65),PlaceholderColor=Color3.fromRGB(178,178,178)},Ocean={TextColor=Color3.fromRGB(230,240,240),Background=
Color3.fromRGB(20,30,30),Topbar=Color3.fromRGB(25,40,40),Shadow=Color3.fromRGB(15,20,20),NotificationBackground=Color3.fromRGB(25,35,35),
NotificationActionsBackground=Color3.fromRGB(230,240,240),TabBackground=Color3.fromRGB(40,60,60),TabStroke=Color3.fromRGB(50,70,70),TabBackgroundSelected=Color3
.fromRGB(100,180,180),TabTextColor=Color3.fromRGB(210,230,230),SelectedTabTextColor=Color3.fromRGB(20,50,50),ElementBackground=Color3.fromRGB(30,50,50),
ElementBackgroundHover=Color3.fromRGB(40,60,60),SecondaryElementBackground=Color3.fromRGB(30,45,45),ElementStroke=Color3.fromRGB(45,70,70),
SecondaryElementStroke=Color3.fromRGB(40,65,65),SliderBackground=Color3.fromRGB(0,110,110),SliderProgress=Color3.fromRGB(0,140,140),SliderStroke=Color3.fromRGB(
0,160,160),ToggleBackground=Color3.fromRGB(30,50,50),ToggleEnabled=Color3.fromRGB(0,130,130),ToggleDisabled=Color3.fromRGB(70,90,90),ToggleEnabledStroke=Color3.
fromRGB(0,160,160),ToggleDisabledStroke=Color3.fromRGB(85,105,105),ToggleEnabledOuterStroke=Color3.fromRGB(50,100,100),ToggleDisabledOuterStroke=Color3.fromRGB(
45,65,65),DropdownSelected=Color3.fromRGB(30,60,60),DropdownUnselected=Color3.fromRGB(25,40,40),InputBackground=Color3.fromRGB(30,50,50),InputStroke=Color3.
fromRGB(50,70,70),PlaceholderColor=Color3.fromRGB(140,160,160)},AmberGlow={TextColor=Color3.fromRGB(255,245,230),Background=Color3.fromRGB(45,30,20),Topbar=
Color3.fromRGB(55,40,25),Shadow=Color3.fromRGB(35,25,15),NotificationBackground=Color3.fromRGB(50,35,25),NotificationActionsBackground=Color3.fromRGB(245,230,
215),TabBackground=Color3.fromRGB(75,50,35),TabStroke=Color3.fromRGB(90,60,45),TabBackgroundSelected=Color3.fromRGB(230,180,100),TabTextColor=Color3.fromRGB(250
,220,200),SelectedTabTextColor=Color3.fromRGB(50,30,10),ElementBackground=Color3.fromRGB(60,45,35),ElementBackgroundHover=Color3.fromRGB(70,50,40),
SecondaryElementBackground=Color3.fromRGB(55,40,30),ElementStroke=Color3.fromRGB(85,60,45),SecondaryElementStroke=Color3.fromRGB(75,50,35),SliderBackground=
Color3.fromRGB(220,130,60),SliderProgress=Color3.fromRGB(250,150,75),SliderStroke=Color3.fromRGB(255,170,85),ToggleBackground=Color3.fromRGB(55,40,30),
ToggleEnabled=Color3.fromRGB(240,130,30),ToggleDisabled=Color3.fromRGB(90,70,60),ToggleEnabledStroke=Color3.fromRGB(255,160,50),ToggleDisabledStroke=Color3.
fromRGB(110,85,75),ToggleEnabledOuterStroke=Color3.fromRGB(200,100,50),ToggleDisabledOuterStroke=Color3.fromRGB(75,60,55),DropdownSelected=Color3.fromRGB(70,50,
40),DropdownUnselected=Color3.fromRGB(55,40,30),InputBackground=Color3.fromRGB(60,45,35),InputStroke=Color3.fromRGB(90,65,50),PlaceholderColor=Color3.fromRGB(
190,150,130)},Light={TextColor=Color3.fromRGB(40,40,40),Background=Color3.fromRGB(245,245,245),Topbar=Color3.fromRGB(230,230,230),Shadow=Color3.fromRGB(200,200,
200),NotificationBackground=Color3.fromRGB(250,250,250),NotificationActionsBackground=Color3.fromRGB(240,240,240),TabBackground=Color3.fromRGB(235,235,235),
TabStroke=Color3.fromRGB(215,215,215),TabBackgroundSelected=Color3.fromRGB(255,255,255),TabTextColor=Color3.fromRGB(80,80,80),SelectedTabTextColor=Color3.
fromRGB(0,0,0),ElementBackground=Color3.fromRGB(240,240,240),ElementBackgroundHover=Color3.fromRGB(225,225,225),SecondaryElementBackground=Color3.fromRGB(235,
235,235),ElementStroke=Color3.fromRGB(210,210,210),SecondaryElementStroke=Color3.fromRGB(210,210,210),SliderBackground=Color3.fromRGB(150,180,220),
SliderProgress=Color3.fromRGB(100,150,200),SliderStroke=Color3.fromRGB(120,170,220),ToggleBackground=Color3.fromRGB(220,220,220),ToggleEnabled=Color3.fromRGB(0,
146,214),ToggleDisabled=Color3.fromRGB(150,150,150),ToggleEnabledStroke=Color3.fromRGB(0,170,255),ToggleDisabledStroke=Color3.fromRGB(170,170,170),
ToggleEnabledOuterStroke=Color3.fromRGB(100,100,100),ToggleDisabledOuterStroke=Color3.fromRGB(180,180,180),DropdownSelected=Color3.fromRGB(230,230,230),
DropdownUnselected=Color3.fromRGB(220,220,220),InputBackground=Color3.fromRGB(240,240,240),InputStroke=Color3.fromRGB(180,180,180),PlaceholderColor=Color3.
fromRGB(140,140,140)},Amethyst={TextColor=Color3.fromRGB(240,240,240),Background=Color3.fromRGB(30,20,40),Topbar=Color3.fromRGB(40,25,50),Shadow=Color3.fromRGB(
20,15,30),NotificationBackground=Color3.fromRGB(35,20,40),NotificationActionsBackground=Color3.fromRGB(240,240,250),TabBackground=Color3.fromRGB(60,40,80),
TabStroke=Color3.fromRGB(70,45,90),TabBackgroundSelected=Color3.fromRGB(180,140,200),TabTextColor=Color3.fromRGB(230,230,240),SelectedTabTextColor=Color3.
fromRGB(50,20,50),ElementBackground=Color3.fromRGB(45,30,60),ElementBackgroundHover=Color3.fromRGB(50,35,70),SecondaryElementBackground=Color3.fromRGB(40,30,55)
,ElementStroke=Color3.fromRGB(70,50,85),SecondaryElementStroke=Color3.fromRGB(65,45,80),SliderBackground=Color3.fromRGB(100,60,150),SliderProgress=Color3.
fromRGB(130,80,180),SliderStroke=Color3.fromRGB(150,100,200),ToggleBackground=Color3.fromRGB(45,30,55),ToggleEnabled=Color3.fromRGB(120,60,150),ToggleDisabled=
Color3.fromRGB(94,47,117),ToggleEnabledStroke=Color3.fromRGB(140,80,170),ToggleDisabledStroke=Color3.fromRGB(124,71,150),ToggleEnabledOuterStroke=Color3.
fromRGB(90,40,120),ToggleDisabledOuterStroke=Color3.fromRGB(80,50,110),DropdownSelected=Color3.fromRGB(50,35,70),DropdownUnselected=Color3.fromRGB(35,25,50),
InputBackground=Color3.fromRGB(45,30,60),InputStroke=Color3.fromRGB(80,50,110),PlaceholderColor=Color3.fromRGB(178,150,200)},Green={TextColor=Color3.fromRGB(30,
60,30),Background=Color3.fromRGB(235,245,235),Topbar=Color3.fromRGB(210,230,210),Shadow=Color3.fromRGB(200,220,200),NotificationBackground=Color3.fromRGB(240,
250,240),NotificationActionsBackground=Color3.fromRGB(220,235,220),TabBackground=Color3.fromRGB(215,235,215),TabStroke=Color3.fromRGB(190,210,190),
TabBackgroundSelected=Color3.fromRGB(245,255,245),TabTextColor=Color3.fromRGB(50,80,50),SelectedTabTextColor=Color3.fromRGB(20,60,20),ElementBackground=Color3.
fromRGB(225,240,225),ElementBackgroundHover=Color3.fromRGB(210,225,210),SecondaryElementBackground=Color3.fromRGB(235,245,235),ElementStroke=Color3.fromRGB(180,
200,180),SecondaryElementStroke=Color3.fromRGB(180,200,180),SliderBackground=Color3.fromRGB(90,160,90),SliderProgress=Color3.fromRGB(70,130,70),SliderStroke=
Color3.fromRGB(100,180,100),ToggleBackground=Color3.fromRGB(215,235,215),ToggleEnabled=Color3.fromRGB(60,130,60),ToggleDisabled=Color3.fromRGB(150,175,150),
ToggleEnabledStroke=Color3.fromRGB(80,150,80),ToggleDisabledStroke=Color3.fromRGB(130,150,130),ToggleEnabledOuterStroke=Color3.fromRGB(100,160,100),
ToggleDisabledOuterStroke=Color3.fromRGB(160,180,160),DropdownSelected=Color3.fromRGB(225,240,225),DropdownUnselected=Color3.fromRGB(210,225,210),
InputBackground=Color3.fromRGB(235,245,235),InputStroke=Color3.fromRGB(180,200,180),PlaceholderColor=Color3.fromRGB(120,140,120)},Bloom={TextColor=Color3.
fromRGB(60,40,50),Background=Color3.fromRGB(255,240,245),Topbar=Color3.fromRGB(250,220,225),Shadow=Color3.fromRGB(230,190,195),NotificationBackground=Color3.
fromRGB(255,235,240),NotificationActionsBackground=Color3.fromRGB(245,215,225),TabBackground=Color3.fromRGB(240,210,220),TabStroke=Color3.fromRGB(230,200,210),
TabBackgroundSelected=Color3.fromRGB(255,225,235),TabTextColor=Color3.fromRGB(80,40,60),SelectedTabTextColor=Color3.fromRGB(50,30,50),ElementBackground=Color3.
fromRGB(255,235,240),ElementBackgroundHover=Color3.fromRGB(245,220,230),SecondaryElementBackground=Color3.fromRGB(255,235,240),ElementStroke=Color3.fromRGB(230,
200,210),SecondaryElementStroke=Color3.fromRGB(230,200,210),SliderBackground=Color3.fromRGB(240,130,160),SliderProgress=Color3.fromRGB(250,160,180),SliderStroke
=Color3.fromRGB(255,180,200),ToggleBackground=Color3.fromRGB(240,210,220),ToggleEnabled=Color3.fromRGB(255,140,170),ToggleDisabled=Color3.fromRGB(200,180,185),
ToggleEnabledStroke=Color3.fromRGB(250,160,190),ToggleDisabledStroke=Color3.fromRGB(210,180,190),ToggleEnabledOuterStroke=Color3.fromRGB(220,160,180),
ToggleDisabledOuterStroke=Color3.fromRGB(190,170,180),DropdownSelected=Color3.fromRGB(250,220,225),DropdownUnselected=Color3.fromRGB(240,210,220),
InputBackground=Color3.fromRGB(255,235,240),InputStroke=Color3.fromRGB(220,190,200),PlaceholderColor=Color3.fromRGB(170,130,140)},DarkBlue={TextColor=Color3.
fromRGB(230,230,230),Background=Color3.fromRGB(20,25,30),Topbar=Color3.fromRGB(30,35,40),Shadow=Color3.fromRGB(15,20,25),NotificationBackground=Color3.fromRGB(
25,30,35),NotificationActionsBackground=Color3.fromRGB(45,50,55),TabBackground=Color3.fromRGB(35,40,45),TabStroke=Color3.fromRGB(45,50,60),TabBackgroundSelected
=Color3.fromRGB(40,70,100),TabTextColor=Color3.fromRGB(200,200,200),SelectedTabTextColor=Color3.fromRGB(255,255,255),ElementBackground=Color3.fromRGB(30,35,40),
ElementBackgroundHover=Color3.fromRGB(40,45,50),SecondaryElementBackground=Color3.fromRGB(35,40,45),ElementStroke=Color3.fromRGB(45,50,60),
SecondaryElementStroke=Color3.fromRGB(40,45,55),SliderBackground=Color3.fromRGB(0,90,180),SliderProgress=Color3.fromRGB(0,120,210),SliderStroke=Color3.fromRGB(0
,150,240),ToggleBackground=Color3.fromRGB(35,40,45),ToggleEnabled=Color3.fromRGB(0,120,210),ToggleDisabled=Color3.fromRGB(70,70,80),ToggleEnabledStroke=Color3.
fromRGB(0,150,240),ToggleDisabledStroke=Color3.fromRGB(75,75,85),ToggleEnabledOuterStroke=Color3.fromRGB(20,100,180),ToggleDisabledOuterStroke=Color3.fromRGB(55
,55,65),DropdownSelected=Color3.fromRGB(30,70,90),DropdownUnselected=Color3.fromRGB(25,30,35),InputBackground=Color3.fromRGB(25,30,35),InputStroke=Color3.
fromRGB(45,50,60),PlaceholderColor=Color3.fromRGB(150,150,160)},Serenity={TextColor=Color3.fromRGB(50,55,60),Background=Color3.fromRGB(240,245,250),Topbar=
Color3.fromRGB(215,225,235),Shadow=Color3.fromRGB(200,210,220),NotificationBackground=Color3.fromRGB(210,220,230),NotificationActionsBackground=Color3.fromRGB(
225,230,240),TabBackground=Color3.fromRGB(200,210,220),TabStroke=Color3.fromRGB(180,190,200),TabBackgroundSelected=Color3.fromRGB(175,185,200),TabTextColor=
Color3.fromRGB(50,55,60),SelectedTabTextColor=Color3.fromRGB(30,35,40),ElementBackground=Color3.fromRGB(210,220,230),ElementBackgroundHover=Color3.fromRGB(220,
230,240),SecondaryElementBackground=Color3.fromRGB(200,210,220),ElementStroke=Color3.fromRGB(190,200,210),SecondaryElementStroke=Color3.fromRGB(180,190,200),
SliderBackground=Color3.fromRGB(200,220,235),SliderProgress=Color3.fromRGB(70,130,180),SliderStroke=Color3.fromRGB(150,180,220),ToggleBackground=Color3.fromRGB(
210,220,230),ToggleEnabled=Color3.fromRGB(70,160,210),ToggleDisabled=Color3.fromRGB(180,180,180),ToggleEnabledStroke=Color3.fromRGB(60,150,200),
ToggleDisabledStroke=Color3.fromRGB(140,140,140),ToggleEnabledOuterStroke=Color3.fromRGB(100,120,140),ToggleDisabledOuterStroke=Color3.fromRGB(120,120,130),
DropdownSelected=Color3.fromRGB(220,230,240),DropdownUnselected=Color3.fromRGB(200,210,220),InputBackground=Color3.fromRGB(220,230,240),InputStroke=Color3.
fromRGB(180,190,200),PlaceholderColor=Color3.fromRGB(150,150,150)}}return b end function a.d():typeof(__modImpl())local b=a.cache.d if not b then b={c=
__modImpl()}a.cache.d=b end return b.c end end do local function __modImpl()local b,c,e,d=a.d(),{},'EZUI'local f,g=e..'/Configurations','.ez'local function 
callSafely(h,...)if h then local i,j=pcall(h,...)if not i then warn('Function failed with error: ',j)return false else return j end end end local function 
ensureFolder(h)if isfolder and not callSafely(isfolder,h)then callSafely(makefolder,h)end end local function SaveConfig()print'Saving Config'local h={}for i,j
in pairs(c.Flags)do print(j)if typeof(j)=='boolean'then if j==false then h[i]=false else h[i]=j end else h[i]=j end end callSafely(writefile,f..'/'..d..g,
tostring(game:GetService'HttpService':JSONEncode(h)))end local function LoadConfig()callSafely(function()if isfile then if callSafely(isfile,f..'/'..d..g)then
local h=callSafely(readfile,f..'/'..d..g)if h then local i,j=pcall(function()return game:GetService'HttpService':JSONDecode(h)end)if i then for k,l in pairs(j)
do c.Flags[k]=l end end end end end end)end c={Flags={},Theme=b,UI=nil,Window=nil,CurrentTheme='Default',GetTheme=function(h)return h.Theme[h.CurrentTheme]end,
Tabs={},Notify=function(h,i)end,LoadConfiguration=function(h)end,CreateUI=function(h)if h.UI then return h.UI end local i=Instance.new('ScreenGui',game.CoreGui)
i.ZIndexBehavior=Enum.ZIndexBehavior.Sibling h.UI=i return i end,CreateWindow=function(h,i)local j=h:CreateUI()if h.Window then return h.Window end local k={}k.
UI=j k.Settings=i if i.Theme then h.CurrentTheme=i.Theme end callSafely(function()if not i.ConfigurationSaving.FileName then i.ConfigurationSaving.FileName=
tostring(game.PlaceId)end if i.ConfigurationSaving.Enabled==nil then i.ConfigurationSaving.Enabled=false end d=i.ConfigurationSaving.FileName f=i.
ConfigurationSaving.FolderName or f if i.ConfigurationSaving.Enabled then ensureFolder(f)end end)LoadConfig()local l,m=h:GetTheme(),Instance.new('Frame',j)m.
BorderSizePixel=0 m.BackgroundColor3=l.Background m.ClipsDescendants=true m.Size=UDim2.new(0,682,0,433)m.Position=UDim2.new(0.5,-341,0.5,-216.5)game:GetService
'UserInputService'.InputBegan:Connect(function(n,o)if n.KeyCode==Enum.KeyCode[i.ToggleUIKeybind]and not o then if m.Parent==nil then m.Parent=j else m.Parent=
nil end end end)local n=Instance.new('UICorner',m)n.CornerRadius=UDim.new(0,16)local o=Instance.new('Frame',m)o.BorderSizePixel=0 o.ClipsDescendants=true o.Size
=UDim2.new(0,682,0,35)o.BackgroundTransparency=1 local p=Instance.new('Frame',o)p.BorderSizePixel=0 p.BackgroundColor3=l.Topbar p.Size=UDim2.new(0,682,0,50)
local q=Instance.new('UICorner',p)q.CornerRadius=UDim.new(0,16)local r=Instance.new('Frame',p)r.BorderSizePixel=0 r.Size=UDim2.new(0,682,0,35)r.
BackgroundTransparency=1 if i.Name then local s=Instance.new('TextLabel',r)s.BorderSizePixel=0 s.TextSize=20 s.TextXAlignment=Enum.TextXAlignment.Left s.
FontFace=Font.new('rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)s.TextColor3=l.TextColor s.BackgroundTransparency
=1 s.Size=UDim2.new(0,634,0,35)s.Text=i.Name s.Position=UDim2.new(0.01884,0,0,0)end local s=Instance.new('TextButton',r)s.BorderSizePixel=0 s.TextSize=14 s.
TextScaled=true s.TextColor3=l.TextColor s.FontFace=Font.new('rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)s.
BackgroundTransparency=1 s.Size=UDim2.new(0,35,0,35)s.Text='\u{d7}'s.Position=UDim2.new(0.94868,0,0,0)local t=Instance.new'Frame't.BorderSizePixel=0 t.Size=
UDim2.new(1,0,0,0)t.Position=UDim2.new(0,0,0,30)t.BackgroundTransparency=1 local u=Instance.new('UIListLayout',t)u.HorizontalAlignment=Enum.HorizontalAlignment.
Center u.FillDirection=Enum.FillDirection.Horizontal local v=Instance.new('Frame',t)v.BorderSizePixel=0 v.BackgroundColor3=Color3.fromRGB(0,0,0)v.AutomaticSize=
Enum.AutomaticSize.XY v.BackgroundTransparency=0.5 local w=Instance.new('UIPadding',v)w.PaddingTop=UDim.new(0,10)w.PaddingBottom=UDim.new(0,10)w.PaddingLeft=
UDim.new(0,15)w.PaddingRight=UDim.new(0,15)local x=Instance.new('UICorner',v)x.CornerRadius=UDim.new(0,16)Instance.new('UIFlexItem',v)local y=Instance.new(
'TextLabel',v)y.BorderSizePixel=0 y.TextSize=20 y.FontFace=Font.new('rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal
)y.TextColor3=Color3.fromRGB(255,255,255)y.BackgroundTransparency=1 y.Text='Show '..i.ShowText y.AutomaticSize=Enum.AutomaticSize.XY v.InputBegan:Connect(
function(z)if z.UserInputType==Enum.UserInputType.MouseButton1 or z.UserInputType==Enum.UserInputType.Touch then m.Parent=j t.Parent=nil end end)s.
MouseButton1Click:Connect(function()m.Parent=nil t.Parent=j end)local z=Instance.new('Frame',m)z.BorderSizePixel=0 z.Size=UDim2.new(0,682,0,398)z.Position=UDim2
.new(0,0,0.08083,0)z.BackgroundTransparency=1 local A=Instance.new('UIListLayout',z)A.Padding=UDim.new(0,5)A.VerticalAlignment=Enum.VerticalAlignment.Bottom A.
SortOrder=Enum.SortOrder.LayoutOrder A.FillDirection=Enum.FillDirection.Horizontal local B=Instance.new('ScrollingFrame',z)B.Active=true B.ScrollingDirection=
Enum.ScrollingDirection.Y B.BorderSizePixel=0 B.CanvasSize=UDim2.new(0,0,0,0)B.AutomaticCanvasSize=Enum.AutomaticSize.Y B.Size=UDim2.new(0,72,0,398)B.
ScrollBarThickness=0 B.BackgroundTransparency=1 Instance.new('UIFlexItem',B)local D=Instance.new('Frame',B)D.BorderSizePixel=0 D.AutomaticSize=Enum.
AutomaticSize.XY D.BackgroundTransparency=1 task.spawn(function()local E=D.Parent local F=E.Parent local function updateWidth()local G=D.AbsoluteSize.X E.Size=
UDim2.new(0,G,1,0)if F then local H=F.Size F.Size=H+UDim2.new(0,1,0,0)F.Size=H end end D:GetPropertyChangedSignal'AbsoluteSize':Connect(updateWidth)end)local E=
Instance.new('UIListLayout',D)E.HorizontalAlignment=Enum.HorizontalAlignment.Center E.Padding=UDim.new(0,10)E.SortOrder=Enum.SortOrder.LayoutOrder local F=
Instance.new('UIPadding',D)F.PaddingTop=UDim.new(0,10)F.PaddingLeft=UDim.new(0,10)F.PaddingRight=UDim.new(0,10)F.PaddingBottom=UDim.new(0,10)local G=Instance.
new('ScrollingFrame',z)G.Active=true G.ScrollingDirection=Enum.ScrollingDirection.Y G.BorderSizePixel=0 G.CanvasSize=UDim2.new(0,0,1,0)G.AutomaticCanvasSize=
Enum.AutomaticSize.Y G.Size=UDim2.new(0,0,0,398)G.ScrollBarThickness=0 G.BackgroundTransparency=1 local H=Instance.new('UIPadding',G)H.PaddingTop=UDim.new(0,10)
H.PaddingRight=UDim.new(0,10)H.PaddingLeft=UDim.new(0,5)H.PaddingBottom=UDim.new(0,10)local I=Instance.new('UIListLayout',G)I.HorizontalFlex=Enum.
UIFlexAlignment.Fill I.Padding=UDim.new(0,10)I.SortOrder=Enum.SortOrder.LayoutOrder local J=Instance.new('UIFlexItem',G)J.FlexMode=Enum.UIFlexMode.Grow local K=
h k.CreateTab=function(L,M)local N=Instance.new('Frame',D)N.BorderSizePixel=0 N.BackgroundColor3=l.TabBackground N.AutomaticSize=Enum.AutomaticSize.X N.Size=
UDim2.new(0,0,0,30)N.Position=UDim2.new(0,0,0,0)N.BackgroundTransparency=0.7 Instance.new('UICorner',N)local P=Instance.new('UIStroke',N)P.Transparency=0.5 P.
Color=l.TabStroke local Q=Instance.new('UIFlexItem',N)Q.ItemLineAlignment=Enum.ItemLineAlignment.Stretch local R=Instance.new('TextLabel',N)R.BorderSizePixel=0
R.TextSize=16 R.TextTransparency=0.2 R.FontFace=Font.new('rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)R.
TextColor3=l.TabTextColor R.BackgroundTransparency=1 R.Size=UDim2.new(0,0,0,30)R.AutomaticSize=Enum.AutomaticSize.X R.Text=M local S=Instance.new('UIPadding',N)
S.PaddingRight=UDim.new(0,10)S.PaddingLeft=UDim.new(0,10)local function selectTab()local T,U=K:GetTheme(),game:GetService'TweenService'U:Create(N,TweenInfo.new(
0.7,Enum.EasingStyle.Exponential),{BackgroundColor3=T.TabBackgroundSelected}):Play()U:Create(N,TweenInfo.new(0.7,Enum.EasingStyle.Exponential),{
BackgroundTransparency=0}):Play()U:Create(P,TweenInfo.new(0.7,Enum.EasingStyle.Exponential),{Transparency=0}):Play()U:Create(R,TweenInfo.new(0.7,Enum.
EasingStyle.Exponential),{TextTransparency=0}):Play()U:Create(R,TweenInfo.new(0.7,Enum.EasingStyle.Exponential),{TextColor3=T.SelectedTabTextColor}):Play()local
V=K.Tabs for W,X in pairs(V)do if X.Name~=M then X:Deselect()else X.Active=true for Y,Z in pairs(X.Content)do Z.Parent=G end end end end N.InputBegan:Connect(
function(T)if T.UserInputType==Enum.UserInputType.MouseButton1 or T.UserInputType==Enum.UserInputType.Touch then selectTab()end end)local T={}T.Name=M T.Content
={}T.Active=false T.Deselect=function(U)local V,W=K:GetTheme(),game:GetService'TweenService'W:Create(N,TweenInfo.new(0.7,Enum.EasingStyle.Exponential),{
BackgroundColor3=V.TabBackground}):Play()W:Create(N,TweenInfo.new(0.7,Enum.EasingStyle.Exponential),{BackgroundTransparency=0.7}):Play()W:Create(P,TweenInfo.
new(0.7,Enum.EasingStyle.Exponential),{Transparency=0.5}):Play()W:Create(R,TweenInfo.new(0.7,Enum.EasingStyle.Exponential),{TextTransparency=0.2}):Play()W:
Create(R,TweenInfo.new(0.7,Enum.EasingStyle.Exponential),{TextColor3=V.TabTextColor}):Play()U.Active=false for X,Y in pairs(U.Content)do Y.Parent=nil end end T.
CreateButton=function(V,W)local X=Instance.new'Frame'X.BorderSizePixel=0 X.BackgroundColor3=l.ElementBackground X.AutomaticSize=Enum.AutomaticSize.X X.Size=
UDim2.new(0,0,0,40)Instance.new('UICorner',X)local Y=Instance.new('UIStroke',X)Y.Color=l.ElementStroke Instance.new('UIFlexItem',X)local Z=Instance.new(
'UIListLayout',X)Z.HorizontalFlex=Enum.UIFlexAlignment.SpaceBetween Z.Padding=UDim.new(0,15)Z.VerticalAlignment=Enum.VerticalAlignment.Center Z.SortOrder=Enum.
SortOrder.LayoutOrder Z.FillDirection=Enum.FillDirection.Horizontal local _=Instance.new('UIPadding',X)_.PaddingRight=UDim.new(0,10)_.PaddingLeft=UDim.new(0,10)
local aa=Instance.new'UIFlexItem'aa.FlexMode=Enum.UIFlexMode.Grow local ab=Instance.new('TextLabel',X)ab.BorderSizePixel=0 ab.TextSize=18 ab.FontFace=Font.new(
'rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)ab.TextColor3=l.TextColor ab.BackgroundTransparency=1 ab.Size=UDim2
.new(0,0,0,30)ab.Text=W.Name ab.AutomaticSize=Enum.AutomaticSize.X X.InputBegan:Connect(function(ac)if ac.UserInputType==Enum.UserInputType.MouseButton1 or ac.
UserInputType==Enum.UserInputType.Touch then task.spawn(function()W:Callback()end)end end)X.MouseEnter:Connect(function()local ac=game:GetService'TweenService'
ac:Create(X,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackgroundHover}):Play()end)X.MouseLeave:Connect(function()local ac=game:
GetService'TweenService'ac:Create(X,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackground}):Play()end)table.insert(V.Content,X)
if V.Active then X.Parent=G end end T.CreateToggle=function(aa,ab)if ab.Flag and K.Flags[ab.Flag]then ab.CurrentValue=K.Flags[ab.Flag]end local ac=Instance.new
'Frame'ac.BorderSizePixel=0 ac.BackgroundColor3=l.ElementBackground ac.AutomaticSize=Enum.AutomaticSize.X ac.Size=UDim2.new(0,0,0,40)Instance.new('UICorner',ac)
local V=Instance.new('UIStroke',ac)V.Color=l.ElementStroke Instance.new('UIFlexItem',ac)local W=Instance.new('UIListLayout',ac)W.HorizontalFlex=Enum.
UIFlexAlignment.SpaceBetween W.Padding=UDim.new(0,15)W.VerticalAlignment=Enum.VerticalAlignment.Center W.SortOrder=Enum.SortOrder.LayoutOrder W.FillDirection=
Enum.FillDirection.Horizontal local X=Instance.new('UIPadding',ac)X.PaddingRight=UDim.new(0,10)X.PaddingLeft=UDim.new(0,10)local Y=Instance.new'UIFlexItem'Y.
FlexMode=Enum.UIFlexMode.Grow local Z=Instance.new('TextLabel',ac)Z.BorderSizePixel=0 Z.TextSize=18 Z.FontFace=Font.new(
'rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)Z.TextColor3=l.TextColor Z.BackgroundTransparency=1 Z.Size=UDim2.
new(0,0,0,30)Z.Text=ab.Name Z.AutomaticSize=Enum.AutomaticSize.X local _=Instance.new('Frame',ac)_.BorderSizePixel=0 _.BackgroundColor3=l.ToggleBackground _.
Size=UDim2.new(0,60,0,30)local ad=Instance.new('UIStroke',_)ad.Color=l.ToggleDisabledOuterStroke local ae=Instance.new('UICorner',_)ae.CornerRadius=UDim.new(0,
999)local af=Instance.new('Frame',_)af.BorderSizePixel=0 af.BackgroundColor3=l.ToggleDisabled af.Size=UDim2.new(0,20,0,20)af.Position=UDim2.new(0,5,0,5)local ag
=Instance.new('UICorner',af)ag.CornerRadius=UDim.new(0,999)local ah=Instance.new('UIStroke',af)ah.Color=l.ToggleDisabledStroke local ai={}ai.CurrentValue=ab.
CurrentValue ai.Set=function(aj,ak)aj.CurrentValue=ak if ab.Flag then K.Flags[ab.Flag]=ak SaveConfig()end task.spawn(function()ab.Callback(ak)end)if ak then
local al=game:GetService'TweenService'al:Create(ad,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{Color=l.ToggleEnabledOuterStroke}):Play()al:Create(af,
TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ToggleEnabled}):Play()al:Create(af,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{Position
=UDim2.new(0,35,0,5)}):Play()al:Create(ah,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{Color=l.ToggleEnabledStroke}):Play()else local al=game:GetService
'TweenService'al:Create(ad,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{Color=l.ToggleDisabledOuterStroke}):Play()al:Create(af,TweenInfo.new(0.6,Enum.
EasingStyle.Exponential),{BackgroundColor3=l.ToggleDisabled}):Play()al:Create(af,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{Position=UDim2.new(0,5,0,5)}):
Play()al:Create(ah,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{Color=l.ToggleDisabledStroke}):Play()end end ai.Toggle=function(aj)aj:Set(not aj.
CurrentValue)end if ab.CurrentValue then ai:Set(ab.CurrentValue)end ac.InputBegan:Connect(function(aj)if aj.UserInputType==Enum.UserInputType.MouseButton1 or aj
.UserInputType==Enum.UserInputType.Touch then ai:Toggle()end end)ac.MouseEnter:Connect(function()local aj=game:GetService'TweenService'aj:Create(ac,TweenInfo.
new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackgroundHover}):Play()end)ac.MouseLeave:Connect(function()local aj=game:GetService
'TweenService'aj:Create(ac,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackground}):Play()end)table.insert(aa.Content,ac)if aa.
Active then ac.Parent=G end return ai end T.CreateSlider=function(aa,ab)if ab.Flag and K.Flags[ab.Flag]then ab.CurrentValue=K.Flags[ab.Flag]end local ac=
Instance.new'Frame'ac.BorderSizePixel=0 ac.BackgroundColor3=l.ElementBackground ac.AutomaticSize=Enum.AutomaticSize.X ac.Size=UDim2.new(0,0,0,40)Instance.new(
'UICorner',ac)local ad=Instance.new('UIStroke',ac)ad.Color=l.ElementStroke Instance.new('UIFlexItem',ac)local ae=Instance.new('UIListLayout',ac)ae.
HorizontalFlex=Enum.UIFlexAlignment.SpaceBetween ae.Padding=UDim.new(0,15)ae.VerticalAlignment=Enum.VerticalAlignment.Center ae.SortOrder=Enum.SortOrder.
LayoutOrder ae.FillDirection=Enum.FillDirection.Horizontal local af=Instance.new('UIPadding',ac)af.PaddingRight=UDim.new(0,10)af.PaddingLeft=UDim.new(0,10)local
ag=Instance.new'UIFlexItem'ag.FlexMode=Enum.UIFlexMode.Grow local ah=Instance.new('TextLabel',ac)ah.BorderSizePixel=0 ah.TextSize=18 ah.FontFace=Font.new(
'rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)ah.TextColor3=l.TextColor ah.BackgroundTransparency=1 ah.Size=UDim2
.new(0,0,0,30)ah.Text=ab.Name ah.AutomaticSize=Enum.AutomaticSize.X local ai=Instance.new('Frame',ac)ai.BorderSizePixel=0 ai.BackgroundColor3=l.SliderBackground
ai.BackgroundTransparency=0.75 ai.Size=UDim2.new(0,270,0,30)local aj=Instance.new('UIStroke',ai)aj.Color=l.SliderStroke local ak=Instance.new('UICorner',ai)ak.
CornerRadius=UDim.new(0,999)local al=Instance.new('Frame',ai)al.BorderSizePixel=0 al.BackgroundColor3=l.SliderProgress al.Size=UDim2.new(0.5,0,1,0)local V=
Instance.new('UICorner',al)V.CornerRadius=UDim.new(0,999)local W,X,Y,Z={},ab.Range and ab.Range[1]or 0,ab.Range and ab.Range[2]or 1,ab.Increment or 0.1 W.
CurrentValue=ab.CurrentValue W.Set=function(_,am)local an=math.clamp(am,X,Y)_.CurrentValue=an if ab.Flag then K.Flags[ab.Flag]=an SaveConfig()end ah.Text=ab.
Name..': '..an..(ab.Suffix or'')local ao,ap=game:GetService'TweenService',(an-X)/(Y-X)ao:Create(al,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{Size=UDim2.
new(ap,0,1,0)}):Play()task.spawn(function()ab.Callback(an)end)end if ab.CurrentValue then W:Set(ab.CurrentValue)end ac.MouseEnter:Connect(function()local am=
game:GetService'TweenService'am:Create(ac,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackgroundHover}):Play()end)ac.MouseLeave:
Connect(function()local am=game:GetService'TweenService'am:Create(ac,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackground}):
Play()end)local am ai.InputBegan:Connect(function(an)if an.UserInputType==Enum.UserInputType.MouseButton1 or an.UserInputType==Enum.UserInputType.Touch then
local ao,ap=game:GetService'UserInputService',ai.AbsoluteSize.X am=game:GetService'RunService'.Stepped:Connect(function()local _=ao:GetMouseLocation().X-ai.
AbsolutePosition.X local aq=_/ap local ar=X+(aq*(Y-X))ar=math.floor(ar/Z)*Z local as=1/Z ar=math.round(ar*as)/as W:Set(ar)end)end end)ai.InputEnded:Connect(
function(an)if an.UserInputType==Enum.UserInputType.MouseButton1 or an.UserInputType==Enum.UserInputType.Touch then am:Disconnect()am=nil end end)table.insert(
aa.Content,ac)if aa.Active then ac.Parent=G end return W end T.CreateKeybind=function(aa,ab)if ab.Flag and K.Flags[ab.Flag]then ab.CurrentKeybind=K.Flags[ab.
Flag]end local ac=Instance.new'Frame'ac.BorderSizePixel=0 ac.BackgroundColor3=l.ElementBackground ac.AutomaticSize=Enum.AutomaticSize.X ac.Size=UDim2.new(0,0,0,
40)Instance.new('UICorner',ac)local ad=Instance.new('UIStroke',ac)ad.Color=l.ElementStroke Instance.new('UIFlexItem',ac)local ae=Instance.new('UIListLayout',ac)
ae.HorizontalFlex=Enum.UIFlexAlignment.SpaceBetween ae.Padding=UDim.new(0,15)ae.VerticalAlignment=Enum.VerticalAlignment.Center ae.SortOrder=Enum.SortOrder.
LayoutOrder ae.FillDirection=Enum.FillDirection.Horizontal local af=Instance.new('UIPadding',ac)af.PaddingRight=UDim.new(0,10)af.PaddingLeft=UDim.new(0,10)local
ag=Instance.new'UIFlexItem'ag.FlexMode=Enum.UIFlexMode.Grow local ah=Instance.new('TextLabel',ac)ah.BorderSizePixel=0 ah.TextSize=18 ah.FontFace=Font.new(
'rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)ah.TextColor3=l.TextColor ah.BackgroundTransparency=1 ah.Size=UDim2
.new(0,0,0,30)ah.Text=ab.Name ah.AutomaticSize=Enum.AutomaticSize.X local ai=Instance.new('Frame',ac)ai.BorderSizePixel=0 ai.BackgroundColor3=l.InputBackground
ai.Size=UDim2.new(0,30,0,30)local aj=Instance.new('UIStroke',ai)aj.Color=l.InputStroke local ak=Instance.new('UICorner',ai)ak.CornerRadius=UDim.new(0,3)local al
=Instance.new('TextBox',ai)al.BorderSizePixel=0 al.TextSize=16 al.TextColor3=l.TextColor al.FontFace=Font.new('rbxasset://fonts/families/SourceSansPro.json',
Enum.FontWeight.Regular,Enum.FontStyle.Normal)al.Size=UDim2.new(1,0,1,0)al.Text=ab.CurrentKeybind or''al.BackgroundTransparency=1 ac.InputBegan:Connect(function
(am)if am.UserInputType==Enum.UserInputType.MouseButton1 or am.UserInputType==Enum.UserInputType.Touch then end end)ac.MouseEnter:Connect(function()local am=
game:GetService'TweenService'am:Create(ac,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackgroundHover}):Play()end)ac.MouseLeave:
Connect(function()local am=game:GetService'TweenService'am:Create(ac,TweenInfo.new(0.6,Enum.EasingStyle.Exponential),{BackgroundColor3=l.ElementBackground}):
Play()end)local am=false al.Focused:Connect(function()am=true al.Text=''end)al.FocusLost:Connect(function()am=false if al.Text==nil or al.Text==''then al.Text=
ab.CurrentKeybind end end)local an=al game:GetService'UserInputService'.InputBegan:Connect(function(ao,ap)if am then if ao.KeyCode~=Enum.KeyCode.Unknown then
local aq=string.split(tostring(ao.KeyCode),'.')local ar=aq[3]an.Text=tostring(ar)ab.CurrentKeybind=tostring(ar)if ab.Flag then K.Flags[ab.Flag]=tostring(ar)
SaveConfig()end an:ReleaseFocus()end elseif ab.CurrentKeybind~=nil and(ao.KeyCode==Enum.KeyCode[ab.CurrentKeybind]and not ap)then ab.Callback()end end)table.
insert(aa.Content,ac)if aa.Active then ac.Parent=G end end T.CreateSection=function(aa,ab)local ac=Instance.new'TextLabel'ac.BorderSizePixel=0 ac.TextSize=20 ac
.FontFace=Font.new('rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)ac.TextColor3=l.TextColor ac.
BackgroundTransparency=1 ac.Size=UDim2.new(0,0,0,30)ac.Text=ab ac.AutomaticSize=Enum.AutomaticSize.X table.insert(aa.Content,ac)if aa.Active then ac.Parent=G
end end T.CreateDropdown=function(aa,ab)end T.CreateLabel=function(aa,ab)local ac=Instance.new'TextLabel'ac.BorderSizePixel=0 ac.TextSize=18 ac.FontFace=Font.
new('rbxasset://fonts/families/SourceSansPro.json',Enum.FontWeight.Regular,Enum.FontStyle.Normal)ac.TextColor3=l.TextColor ac.BackgroundTransparency=1 ac.Size=
UDim2.new(0,0,0,30)ac.Text=ab ac.AutomaticSize=Enum.AutomaticSize.X table.insert(aa.Content,ac)if aa.Active then ac.Parent=G end end table.insert(K.Tabs,T)if K.
Tabs[1].Name==M then selectTab()end return T end k.Frame=m h.Window=k return k end}return c end function a.e():typeof(__modImpl())local aa=a.cache.e if not aa
then aa={c=__modImpl()}a.cache.e=aa end return aa.c end end do local function __modImpl()local aa,ab,ac=a.c(),{Name="Luke's Script Hub",Icon=0,LoadingTitle=
"Luke's Script Hub",LoadingSubtitle='by @actuallyluke',ShowText='Menu',Theme='Default',ToggleUIKeybind='K',DisableRayfieldPrompts=true,DisableBuildWarnings=
false,ConfigurationSaving={Enabled=true,FolderName=nil,FileName='Lukes Script Hub'},KeySystem=false},{}if aa.isKBM()then ac.Library=a.e()else ac.Library=
loadstring(game:HttpGet'https://sirius.menu/rayfield')()end ac.Window=ac.Library:CreateWindow(ab)return ac end function a.f():typeof(__modImpl())local aa=a.
cache.f if not aa then aa={c=__modImpl()}a.cache.f=aa end return aa.c end end do local function __modImpl()local aa,ab=a.f(),a.c()local ac=aa.Window:CreateTab(
'Universal','globe')ac:CreateSection'Noclip'local ae=ac:CreateToggle{Name='Toggle Noclip',CurrentValue=false,Flag=nil,Callback=function(ae)if ae then ab.Noclip.
enable()ab.Noclip.set_manual(ae)else ab.Noclip.set_manual(ae)ab.Noclip.disable()end end}ac:CreateKeybind{Name='Toggle Noclip',CurrentKeybind='V',HoldToInteract=
false,Flag='NoClipKeybind',Callback=function()if ae.CurrentValue then aa.Library:Notify{Title='Noclip Disabled',Content='Noclip is now disabled.',Duration=3,
Image='ban'}else aa.Library:Notify{Title='Noclip Enabled',Content='Noclip is now enabled.',Duration=3,Image='check'}end ae:Set(not ae.CurrentValue)end}ac:
CreateSection'Path'local ah=false ac:CreateKeybind{Name='Toggle Paths',CurrentKeybind='N',HoldToInteract=false,Flag='PathKeybind',Callback=function()ah=not ah
end}task.spawn(function()local aj local function getPath()if not aj then aj=Instance.new('Part',game.Workspace)aj.Size=Vector3.new(3,1,3)aj.Anchored=true end
return aj end while task.wait()do if ah==true then local ak,al=getPath(),game:GetService'Players'.LocalPlayer local am=al and al.Character local an,ao=am and am
:FindFirstChild'HumanoidRootPart',am and am:FindFirstChildWhichIsA'Humanoid'local ap=ao and ao.RigType if an and ao and ap then if ap==Enum.HumanoidRigType.R15
then local aq,ar=an.Size.Y,ao.HipHeight ak.CFrame=an.CFrame*CFrame.new(0,-(aq/2)-ar-0.5,0)else local aq=am and am:FindFirstChild'Left Leg'if aq then local ar,as
=an.Size.Y,aq.Size.Y ak.CFrame=an.CFrame*CFrame.new(0,-(ar/2)-as-0.5,0)end end end else if aj then aj:Destroy()aj=nil end end end end)ac:CreateSection
'Ctrl+Click Delete'ac:CreateLabel[[Ctrl+Left-Click a part to delete. Ctrl+Right-Click to restore]]local al=true ac:CreateToggle{Name='Ctrl+Click Delete',
CurrentValue=true,Flag=nil,Callback=function(am)al=am end}task.spawn(function()local an=game:GetService'Players'.LocalPlayer local ao,ap=an:GetMouse(),Instance.
new('Folder',game.Workspace)ap.Name='DELETED_PARTS'local aq=Instance.new('IntValue',game.Workspace)aq.Name='DELETED_PART_INDEX'aq.Value=0 local function get()
return aq.Value end local function set(ar)aq.Value=ar end local function inc()local ar=get()set(ar+1)end local function dec()local ar=get()set(ar-1)end local 
function isControlDown()local ar=game:GetService'UserInputService'return ar:IsKeyDown(Enum.KeyCode.LeftControl)or ar:IsKeyDown(Enum.KeyCode.LeftMeta)end ao.
Button1Down:Connect(function()if al and isControlDown()and ao.Target then inc()local ar=Instance.new('ObjectValue',ap)ar.Value=ao.Target ar.Name=''..get()local
as=Instance.new('Vector3Value',ar)as.Value=ao.Target.Position as.Name='pos'ao.Target.Position=Vector3.new(100000000,100000000,100000000)end end)ao.Button2Down:
Connect(function()if al and isControlDown()then local ar=ap:FindFirstChild(tostring(get()))if ar and ar.Value then local as=ar:FindFirstChild'pos'if as and as.
Value then ar.Value.Position=as.Value ar:Destroy()dec()end end end end)end)ac:CreateSection'Aimlock'ac:CreateKeybind{Name='Toggle Aimlock',CurrentKeybind='Z',
HoldToInteract=false,Flag='AimLockKeybind',Callback=ab.Aimlock.toggleLock}ac:CreateSection'Universal ESP'local function updateUniversalESP(ap)for aq,ar in
pairs(game:GetService'Players':GetPlayers())do if ar~=game:GetService'Players'.LocalPlayer then ab.updatePlayerESP(ar,Color3.fromRGB(255,0,0),ap,Color3.fromRGB(
255,0,255))end end end local ap=false ac:CreateToggle{Name='Universal ESP',CurrentValue=false,Flag=nil,Callback=function(aq)ap=aq updateUniversalESP(ap)end}game
:GetService'RunService'.RenderStepped:Connect(function()if ap then updateUniversalESP(ap)end end)ac:CreateToggle{Name='Show Player Names',CurrentValue=ab.
esp_show_names,Flag='EspShowNames',Callback=function(ar)ab.esp_show_names=ar end}ac:CreateToggle{Name='Show Player Health',CurrentValue=ab.esp_show_health,Flag=
'EspShowHealth',Callback=function(as)ab.esp_show_health=as end}local b=game:GetService'Players'.LocalPlayer local c=b and b.Character local d=c and c:
FindFirstChild'Humanoid'local e=(d and d.WalkSpeed)or 16 ac:CreateSection'Speed'local g=ac:CreateSlider{Name='Speed',Range={0,100},Increment=1,Suffix='',
CurrentValue=e,Flag=nil,Callback=function(g)local h=game:GetService'Players'.LocalPlayer local i=h and h.Character local j=i and i:FindFirstChildWhichIsA
'Humanoid'if j then j.WalkSpeed=g end end}ac:CreateButton{Name='Set to 16',Callback=function()g:Set(16)end}ac:CreateButton{Name='Set to 18',Callback=function()g
:Set(18)end}ac:CreateButton{Name='Set to 20',Callback=function()g:Set(20)end}local h,i ac:CreateToggle{Name='Loop Speed',CurrentValue=false,Flag=nil,Callback=
function(j)local k=game:GetService'Players'.LocalPlayer local l=k and k.Character local m=l and l:FindFirstChildWhichIsA'Humanoid'if j and m then local function 
SetWalkspeed()local n=game:GetService'Players'.LocalPlayer local o=n and n.Character local p=o and o:FindFirstChildWhichIsA'Humanoid'if p then p.WalkSpeed=g.
CurrentValue end end SetWalkspeed()h=(h and h:Disconnect()and false)or m:GetPropertyChangedSignal'WalkSpeed':Connect(SetWalkspeed)i=(i and i:Disconnect()and
false)or k.CharacterAdded:Connect(function(n)m=n:WaitForChild'Humanoid'SetWalkspeed()h=(h and h:Disconnect()and false)or m:GetPropertyChangedSignal'WalkSpeed':
Connect(SetWalkspeed)end)else h=(h and h:Disconnect()and false)or nil i=(i and i:Disconnect()and false)or nil end end}return true end function a.g():typeof(
__modImpl())local aa=a.cache.g if not aa then aa={c=__modImpl()}a.cache.g=aa end return aa.c end end do local function __modImpl()a.c()local ab={}function ab.
getMap()local ac=game.Workspace:FindFirstChild'Map'return ac end function ab.getFunctionals()local ac=ab.getMap()local ad=ac and ac:FindFirstChild'Functionals'
return ad end function ab.getComputers()local ac=ab.getFunctionals()local ad=ac and ac:FindFirstChild'Computers'if ad then return ad:GetChildren()else return{}
end end function ab.getComputerModel(ac)local ad=ac and ac:FindFirstChild'ComputerModel'return ad end function ab.getComputerScreen(ac)local ad=ac and ac:
FindFirstChild'Screen'return ad end function ab.getComputerColor(ac)local ad=ab.getComputerScreen(ac)local ae=(ad and ad.Color)or Color3.fromRGB(0,0,255)return
ae end function ab.getBeasts()local ac=game.Workspace:FindFirstChild'Beasts'if ac then return ac:GetChildren()else return{}end end function ab.getSurvivors()
local ac=game.Workspace:FindFirstChild'Survivors'if ac then return ac:GetChildren()else return{}end end return ab end function a.h():typeof(__modImpl())local aa
=a.cache.h if not aa then aa={c=__modImpl()}a.cache.h=aa end return aa.c end end do local function __modImpl()local function init()local aa,ab,ac=a.f(),a.c(),a.
h()local ad=aa.Window:CreateTab('Agoraphobia','gamepad-2')ad:CreateSection'ESP'local ae=true local function updateSurvivorESP()local af=ac.getSurvivors()for ag,
ah in pairs(af)do local ai=game:GetService'Players':FindFirstChild(ah.Name)ab.updatePlayerESP(ai,Color3.fromRGB(0,255,0),ae,Color3.fromRGB(255,0,255))end end
local function updateBeastESP()local af=ac.getBeasts()for ag,ah in pairs(af)do local ai=game:GetService'Players':FindFirstChild(ah.Name)ab.updatePlayerESP(ai,
Color3.fromRGB(255,0,0),ae,Color3.fromRGB(255,0,255))end end local function updatePlayerESP()updateSurvivorESP()updateBeastESP()end local af=true local function 
updateComputerESP()local ag=ac.getComputers()for ah,ai in pairs(ag)do local aj,ak=ac.getComputerModel(ai),ac.getComputerColor(ai)if aj then ab.updateESP(aj,ak,
af)end end end ad:CreateToggle{Name='Player ESP',CurrentValue=true,Flag=nil,Callback=function(ag)ae=ag updatePlayerESP()end}ad:CreateToggle{Name='Computer ESP',
CurrentValue=true,Flag=nil,Callback=function(ah)af=ah updateComputerESP()end}task.spawn(function()while task.wait(1)do updatePlayerESP()updateComputerESP()end
updatePlayerESP()updateComputerESP()end)end return init end function a.i():typeof(__modImpl())local aa=a.cache.i if not aa then aa={c=__modImpl()}a.cache.i=aa
end return aa.c end end do local function __modImpl()local aa,ab=a.c(),{}ab.Queue={running=false,items={},add=function(ac,ad,ae)table.insert(ac.items,{item=ad,
onDone=ae})end,update=function(ac)if not ac.running and#ac.items>0 then local ad=table.remove(ac.items,1)ac.running=true ad.item()ac.running=false if ad.onDone
then ad.onDone()end end end}task.spawn(function()while task.wait()do ab.Queue:update()end end)function ab.getItemFolders()if ab.ItemFolders then return ab.
ItemFolders end local ac={}for ad,ae in pairs(game.Workspace:GetChildren())do if ae.Name=='Model'then local af=ae:FindFirstChild'Items'if af then table.insert(
ac,af)end end end ab.ItemFolders=ac return ac end function ab.getItems()if ab.Items then return ab.Items end local ac,ad={},ab.getItemFolders()for ae,af in
pairs(ad)do for ag,ah in pairs(af:GetChildren())do table.insert(ac,ah)end end ab.Items=ac return ac end function ab.getItem(ac)local ad=ab.getItems()for ae,af
in pairs(ad)do if af.Name==ac then return af end end return nil end function ab.fireProximityPrompt(ac,ad)local ae=game:GetService'Players'.LocalPlayer local af
=ae and ae.Character local ag=af and af:FindFirstChild'HumanoidRootPart'if ag then local ah,ai=game.Workspace.CurrentCamera,ag.CFrame local aj,ak=ah.CFrame,game
.Workspace.Gravity task.wait()aa.Noclip.enable()game.Workspace.Gravity=0 task.wait()ag.CFrame=ad.CFrame*CFrame.new(0,0,-2)ah.CFrame=CFrame.lookAt(ah.CFrame.
Position,ad.Position)task.wait()local al=ac.Enabled ac.Enabled=false ac.Enabled=true local am=game.Workspace:GetRealPhysicsFPS()if am<10 then am=60 end local an
,ao=am/6,0 repeat task.wait()ao=ao+1 until ac:InputHoldBegin()or ao>an if fireproximityprompt then fireproximityprompt(ac)else task.wait(ac.HoldDuration)end ac:
InputHoldEnd()task.wait()ac.Enabled=al ag.CFrame=ai ah.CFrame=aj task.wait()aa.Noclip.disable()game.Workspace.Gravity=ak aa.breakVelocity(0.5)task.wait()local
ap=game:GetService'Players'.LocalPlayer local aq=ap and ap.Character local ar=aq and aq:FindFirstChildWhichIsA'Humanoid'ar.PlatformStand=false end end function
ab.grabItem(ac)local ad=ab.getItem(ac)if ad then local ae,af=ad:FindFirstChild'PP',ad.PrimaryPart or ad:FindFirstChildWhichIsA'BasePart'if ae and af then ab.
Queue:add(function()ab.fireProximityPrompt(ae,af)end)end end end function ab.getCheckInHL()local ac=game.Workspace:FindFirstChild'Misc'local ad=ac and ac:
FindFirstChild'CheckIn'local ae=ad and ad:FindFirstChild('CheckStepHighlight',true)return ae end function ab.getNPCHL()local ac=game.Workspace:FindFirstChild
'NPCs'local ad=ac and(ac:FindFirstChild('CheckStepHighlight',true)or ac:FindFirstChild('PatientHighlight',true))return ad end function ab.getMedicalHL()local ac
=game.Workspace:FindFirstChild'Rooms'local ad=ac and ac:FindFirstChild'Medical'local ae=ad and ad:FindFirstChild('PatientHighlight',true)return ae end function
ab.getPPFromHL(ac)return ac.Parent.Parent:FindFirstChild'PP2'or ac.Parent:FindFirstChild'PP'end return ab end function a.j():typeof(__modImpl())local aa=a.cache
.j if not aa then aa={c=__modImpl()}a.cache.j=aa end return aa.c end end do local function __modImpl()local aa,ab=a.j(),{}function ab.getEyeDrops()aa.grabItem
'Eye Drops'end function ab.getIVDrops()aa.grabItem'IV Drops'end function ab.getMedkit()aa.grabItem'Medkit'end function ab.getThermo()aa.grabItem'Thermo'end
function ab.getOintment()aa.grabItem'Ointment'end function ab.getBandages()aa.grabItem'Bandages'end function ab.getMapleSyrup()aa.grabItem'Maple Syrup'end
function ab.getCoughSyrup()aa.grabItem'Cough Syrup'end function ab.getMedicine()aa.grabItem'Medicine'end function ab.getHerbs()aa.grabItem'Herbs'end local ac=
false function ab.toggleAutoCheckIn(ad)ac=ad end local ad=false function ab.toggleAutoNPC(ae)ad=ae end local ae=false function ab.toggleAutoMedical(af)ae=af end
task.spawn(function()local af=true while task.wait()do if(ac or ad or ae)and af then local ag=(ac and aa.getCheckInHL())or(ad and aa.getNPCHL())or(ae and aa.
getMedicalHL())if ag then local ah=aa.getPPFromHL(ag)if ah then local ai=ah.Parent local aj=ai.PrimaryPart or ai:FindFirstChildWhichIsA'BasePart'if aj then af=
false aa.Queue:add(function()aa.fireProximityPrompt(ah,aj)end,function()af=true end)end end end end end end)return ab end function a.k():typeof(__modImpl())
local aa=a.cache.k if not aa then aa={c=__modImpl()}a.cache.k=aa end return aa.c end end do local function __modImpl()local function init()local aa,ab=a.f(),a.
k()local ac=aa.Window:CreateTab('Animal Hospital','gamepad-2')ac:CreateSection'Utils'ac:CreateToggle{Name='Auto Check-In',CurrentValue=false,Flag=nil,Callback=
ab.toggleAutoCheckIn}ac:CreateToggle{Name='Auto NPC',CurrentValue=false,Flag=nil,Callback=ab.toggleAutoNPC}ac:CreateToggle{Name='Auto Medical',CurrentValue=
false,Flag=nil,Callback=ab.toggleAutoMedical}ac:CreateSection'Items'ac:CreateButton{Name='Bandages',Callback=ab.getBandages}ac:CreateButton{Name='Cough Syrup',
Callback=ab.getCoughSyrup}ac:CreateButton{Name='Eye Drops',Callback=ab.getEyeDrops}ac:CreateButton{Name='Herbs',Callback=ab.getHerbs}ac:CreateButton{Name=
'IV Drops',Callback=ab.getIVDrops}ac:CreateButton{Name='Maple Syrup',Callback=ab.getMapleSyrup}ac:CreateButton{Name='Medicine',Callback=ab.getMedicine}ac:
CreateButton{Name='Medkit',Callback=ab.getMedkit}ac:CreateButton{Name='Ointment',Callback=ab.getOintment}ac:CreateButton{Name='Thermo',Callback=ab.getThermo}end
return init end function a.l():typeof(__modImpl())local aa=a.cache.l if not aa then aa={c=__modImpl()}a.cache.l=aa end return aa.c end end do local function 
__modImpl()local aa,ab=a.c(),{}function ab.getCurrentMap()for ac,ad in pairs(game.Workspace:GetChildren())do if ad:FindFirstChild'ComputerTable'then return ad
end end return nil end function ab.getCurrentMapChildren()local ac=ab.getCurrentMap()if not ac then return{}end return ac:GetChildren()end function ab.getExits(
)local ac,ad={},ab.getCurrentMapChildren()for ae,af in pairs(ad)do if af.Name=='ExitDoor'then table.insert(ac,af)end end return ac end function ab.getExitArea(
ac)local ad=ac:FindFirstChild'ExitArea'return ad end function ab.getExitTrigger(ac)local ad=ac:FindFirstChild'ExitDoorTrigger'return ad end function ab.
exitNeedsToOpen(ac)local ad=ab.getExitTrigger(ac)local ae=ad and ad:FindFirstChild'ActionSign'if ae then return ae.Value~=0 end return false end function ab.
exitIsOpen(ac)local ad=ab.getExitTrigger(ac)if not ad then return true end return false end function ab.getClosestClosedExit()local ac,ad=ab.getExits(),{}for ae
,af in pairs(ac)do if not ab.exitIsOpen(af)and ab.exitNeedsToOpen(af)then table.insert(ad,af)end end local af,ag,ae=99999999,game:GetService'Players'.
LocalPlayer local ah=ag and ag.Character local ai=ah and ah:FindFirstChild'HumanoidRootPart'if ai then for aj,ak in pairs(ad)do local al=ab.getExitTrigger(ak)
local am=aa.dist3d(al.Position,ai.Position)if am<af then af=am ae=ak end end end return ae end function ab.findOpenExit()local ac={}for ad,ae in pairs(ab.
getExits())do if ab.exitIsOpen(ae)then table.insert(ac,ae)end end local ae,af,ad=99999999,game:GetService'Players'.LocalPlayer local ag=af and af.Character
local ah=ag and ag:FindFirstChild'HumanoidRootPart'if ah then for ai,aj in pairs(ac)do local ak=ab.getExitArea(aj)local al=aa.dist3d(ak.Position,ah.Position)if
al<ae then ae=al ad=aj end end end return ad end function ab.findBeast()for ac,ad in pairs(game:GetService'Players':GetPlayers())do if ad.Character and ad.
Character:FindFirstChild'BeastPowers'and ad~=game:GetService'Players'.LocalPlayer then return ad end end return nil end function ab.findBeastIncludingLocal()for
ac,ad in pairs(game:GetService'Players':GetPlayers())do if ad.Character and ad.Character:FindFirstChild'BeastPowers'then return ad end end return nil end
function ab.getHammer()local ac=ab.findBeastIncludingLocal()local ad=ac and ac.Character local ae=ad and ad:FindFirstChild'Hammer'return ae end function ab.
getHammerHandle()local ac=ab.findBeast()local ad=ac and ac.Character local ae=ad and ad:FindFirstChild'Hammer'local af=ae and ae:FindFirstChild'Handle'return af
end function ab.getHammerEvent()local ac=ab.getHammer()if ac then return ac:FindFirstChild'HammerEvent'end return nil end function ab.getPowerEvent()local ac=ab
.findBeastIncludingLocal()local ad=ac and ac.Character local ae=ad and ad:FindFirstChild'BeastPowers'local af=ae and ae:FindFirstChild'PowersEvent'return af end
function ab.clickHammer()local ac=ab.getHammerEvent()if ac then ac:FireServer('HammerClick',true)end end function ab.getStats(ac)local ad=ac and ac:
FindFirstChild'TempPlayerStatsModule'return ad end function ab.isRagdoll(ac)local ad=ab.getStats(ac)local ae=ad and ad:FindFirstChild'Ragdoll'local af=ae and ae
.Value if af==nil then return false end return af end function ab.isCaptured(ac)local ad=ab.getStats(ac)local ae=ad and ad:FindFirstChild'Captured'local af=ae
and ae.Value if af==nil then return false end return af end function ab.hitPlayer(ac)local ad=ac and ac.Character local ae=ad and ad:FindFirstChild
'HumanoidRootPart'if ae then local af=ab.getHammerEvent()if af then ab.clickHammer()af:FireServer('HammerHit',ae)end end end function ab.tiePlayer(ac)local ad=
ac and ac.Character local ae=ad and ad:FindFirstChild'HumanoidRootPart'if ae then local af=ab.getHammerEvent()if af then af:FireServer('HammerTieUp',ae,ae.
Position)end end end function ab.getChaseMusic()local ac=ab.getHammerHandle()local ad=ac and ac:FindFirstChild'SoundChaseMusic'return ad end local ac,ad=0.4,0.4
task.spawn(function()while task.wait()do local ae=ab.getChaseMusic()if ae then ae.Volume=ad end end end)function ab.updateChaseVolume(ae)ad=((ae/100)*ac)end
function ab.isGameActive()return game.ReplicatedStorage.IsGameActive.Value and game.ReplicatedStorage.GameTimer.Value~=0 end function ab.isBeast()local ae=game:
GetService'Players'.LocalPlayer local af=ae and ae.Character if ab.isGameActive()and af then task.wait()return af:FindFirstChild'BeastPowers'end return false
end function ab.getDistToBeast()local ae=ab.findBeast()local af=ae and ae.Character local ag,ah=af and af:FindFirstChild'HumanoidRootPart',game:GetService
'Players'.LocalPlayer local ai=ah and ah.Character local aj=ai and ai:FindFirstChild'HumanoidRootPart'if ag and aj then return aa.dist3d(aj.Position,ag.Position
)end return 99999999 end function ab.getActivePlayers()local ae,af={},game:GetService'Players'.LocalPlayer local ag=af and af:FindFirstChild'PlayerGui'local ah=
ag and ag:FindFirstChild'ScreenGui'local ai=ah and ah:FindFirstChild'StatusBars'local aj=ai and ai:GetChildren()if aj then for ak,al in pairs(aj)do if al:IsA
'TextLabel'and al.TextColor3==Color3.fromRGB(255,255,255)then local am=al.ContentText local an=game:GetService'Players':FindFirstChild(am)if an then table.
insert(ae,an)end end end end return ae end function ab.isPlayerCaptured(ae)local af=ab.getStats(ae)local ag=af and af:FindFirstChild'Captured'if ag then return
ag.Value end return false end function ab.getCapturablePlayers()local ae,af={},game:GetService'Players'.LocalPlayer for ag,ah in pairs(ab.getActivePlayers())do
if ah~=af then if not ab.isPlayerCaptured(ah)then table.insert(ae,ah)end end end return ae end function ab.triggerEvent(ae,af)local ag=game:GetService
'ReplicatedStorage'.RemoteEvent ag:FireServer('Input','Trigger',af,ae)end function ab.triggerInput(ae)local af=game:GetService'ReplicatedStorage'.RemoteEvent af
:FireServer('Input','Action',ae)end function ab.triggerCrawl(ae)local af=game:GetService'ReplicatedStorage'.RemoteEvent af:FireServer('Input','Crawl',ae)end
function ab.triggerPod(ae)local af=ae:FindFirstChild'Event'if af then local ag=ab.getStats(game:GetService'Players'.LocalPlayer)local ah=ag and ag:
FindFirstChild'ActionEvent'local ai=ah and ah.Value task.spawn(function()ab.triggerEvent(af,true)ab.triggerInput(true)task.wait(1)ab.triggerEvent(af,false)ab.
triggerInput(false)task.wait(1)if ai then ab.triggerEvent(ai,true)ab.triggerInput(true)end end)end end function ab.findNearestFreezePod()local af,ag,ae=99999999
,game:GetService'Players'.LocalPlayer local ah=ag and ag.Character local ai=ah and ah:FindFirstChild'HumanoidRootPart'for aj,ak in pairs(game.Workspace:
GetDescendants())do if ak.Name=='FreezePod'then local al=ak:FindFirstChild'PodTrigger'if al then local am=al:FindFirstChild'CapturedTorso'if am.Value==nil then
local an=aa.dist3d(ai.Position,al.Position)if an<af then ae=al af=an end end end end end return ae end function ab.triggerNearestFreezePod()local ae=ab.
findNearestFreezePod()if ae then ab.triggerPod(ae)end end function ab.teleportToNearestFreezePod()local ae=game:GetService'Players'.LocalPlayer local af=ae and
ae.Character local ag=af and af:FindFirstChild'HumanoidRootPart'if ag then local ah=ab.findNearestFreezePod()aa.Noclip.enable()ag.CFrame=ah.CFrame task.delay(1,
aa.Noclip.disable)end end function ab.isInGame()local ae,af=game:GetService'Players'.LocalPlayer,ab.getActivePlayers()if ae and af then for ag,ah in pairs(af)do
if ah==ae then return true end end end return false end function ab.partCloseToModel(ae,af,ag)local ah if af.PrimaryPart then ah=af.PrimaryPart else local ai=af
:GetDescendants()for aj,ak in pairs(ai)do if ak:IsA'BasePart'then ah=ak break end end end if ae and ah then local ai=aa.dist3d(ae.Position,ah.Position)return ai
<=ag end return false end function ab.isCloseToModel(ae,af)local ag=game:GetService'Players'.LocalPlayer local ah=ag and ag.Character local ai=ah and ah:
FindFirstChild'HumanoidRootPart'return ab.partCloseToModel(ai,ae,af)end function ab.partCloseToModelName(ae,af,ag)for ah,ai in pairs(ab.getCurrentMapChildren())
do if ai.Name==af then if ab.partCloseToModel(ae,ai,ag)then return true,ai end end end return false,nil end function ab.isCloseToModelName(ae,af)for ag,ah in
pairs(ab.getCurrentMapChildren())do if ah.Name==ae then if ab.isCloseToModel(ah,af)then return true,ah end end end return false,nil end function ab.
partCloseToComputer(ae)return ab.partCloseToModelName(ae,'ComputerTable',20)end function ab.isCloseToComputer()return ab.isCloseToModelName('ComputerTable',8.5)
end function ab.isCloseToFreezePod()return ab.isCloseToModelName('FreezePod',10)end function ab.isCloseToExit()return ab.isCloseToModelName('ExitDoor',20)end
function ab.getLockers()return game:GetService'CollectionService':GetTagged'LOCKER'end function ab.findNearestLocker()local ae=game:GetService'Players'.
LocalPlayer local af=ae and ae.Character local ag=af and af:FindFirstChild'HumanoidRootPart'if ag then local ai,ah=999999999 for aj,ak in pairs(ab.getLockers())
do local al=ak:FindFirstChildOfClass'Part'if al then local am=aa.dist3d(ag.Position,al.Position)if am<ai then ai=am ah=ak end end end return ah end return nil
end function ab.getCurrentPower()local ae=game:GetService'ReplicatedStorage':FindFirstChild'CurrentPower'if ae then return ae.Value end return''end function ab.
isPowerActive()local ae=game:GetService'ReplicatedStorage':FindFirstChild'PowerActive'if ae then return ae.Value end return false end function ab.isSeerActive()
local ae=ab.getCurrentPower()=='Seer'return ae and ab.isPowerActive()end local ae,af=Color3.fromRGB(13,105,172),Color3.fromRGB(196,40,28)function ab.
getClosestComputer(ag)local ah=game:GetService'Players'.LocalPlayer local ai=ah and ah.Character local aj,al,ak=ai and ai:FindFirstChild'HumanoidRootPart',
99999999 if aj then for am,an in pairs(ab.getCurrentMapChildren())do if an.Name=='ComputerTable'then local ao=an.PrimaryPart if ao then local ap=aa.dist3d(aj.
Position,ao.Position)if ag then if ap<al then al=ap ak=an end else local aq=an:FindFirstChild'Screen'if aq and(aq.Color==ae or aq.Color==af)then if ap<al then
al=ap ak=an end end end end end end end return ak end function ab.getValidSpot(ag)local ah=ag:FindFirstChild'Screen'if ah and(ah.Color==ae or ah.Color==af)then
local ai,aj,ak=ag:FindFirstChild'ComputerTrigger1',ag:FindFirstChild'ComputerTrigger2',ag:FindFirstChild'ComputerTrigger3'local al,am={ai,aj,ak},{}for an,ao in
pairs(al)do local ap=ao:FindFirstChild'ActionSign'if ap then if ap.Value~=0 then table.insert(am,ao)end end end local an,ap,ao=99999999,game:GetService'Players'
.LocalPlayer local aq=ap and ap.Character local ar=aq and aq:FindFirstChild'HumanoidRootPart'if ar then for as,b in pairs(am)do local c=aa.dist3d(ar.Position,b.
Position)if c<an then an=c ao=b end end end return ao end return nil end local ag=20 ab.beast_max_dist=ag function ab.doBeastRaycast(ah)local ai=ab.findBeast()
local aj=ai and ai.Character local ak=aj and aj:FindFirstChild'Head'if ak and ah then local al,am=ah.Position,ak.Position local an,ao,ap=(am-al)*1.5,game:
GetService'Players':GetPlayers(),{ah,ah.Parent}for aq,ar in pairs(ao)do local as=ar.Character if as and ar~=ai then table.insert(ap,as)end end local aq=
RaycastParams.new()aq.FilterType=Enum.RaycastFilterType.Exclude aq.FilterDescendantsInstances=ap aq.IgnoreWater=true local ar=game.Workspace:Raycast(al,an,aq)if
ar then local as=ar.Instance if as then if as:IsDescendantOf(aj)then return true end end end end return false end function ab.LOSToBeast()local ah=game:
GetService'Players'.LocalPlayer local ai=ah and ah.Character local aj,ak,al,am=ai and ai:FindFirstChild'HumanoidRootPart',ai and ai:FindFirstChild'Head',ai and
ai:FindFirstChild'Left Leg',ai and ai:FindFirstChild'Right Leg'local an={aj,ak,al,am}for ao,ap in pairs(an)do if ap then if ab.doBeastRaycast(ap)then return
true end end end return false end function ab.isInDanger()return ab.getDistToBeast()<=ag and ab.LOSToBeast()end function ab.shouldEasyHack()return ab.
getDistToBeast()>30 or not ab.LOSToBeast()end return ab end function a.m():typeof(__modImpl())local aa=a.cache.m if not aa then aa={c=__modImpl()}a.cache.m=aa
end return aa.c end end do local function __modImpl()local function init()local aa,ab,ac=a.f(),a.c(),a.m()local ad,ae=aa.Window:CreateTab'ESP',true function
UpdateBeastESP()for af,ag in pairs(game.Players:GetPlayers())do if ag.Character and ag.Character:FindFirstChild'BeastPowers'and ag~=game.Players.LocalPlayer
then ab.updatePlayerESP(ag,Color3.fromRGB(255,0,0),ae,Color3.fromRGB(255,0,255))end end end ad:CreateToggle{Name='Beast ESP',CurrentValue=true,Flag=nil,Callback
=function(af)ae=af UpdateBeastESP()end}local ag=true function UpdatePlrESP()for ah,ai in pairs(game.Players:GetPlayers())do if ai.Character and not ai.Character
:FindFirstChild'BeastPowers'and ai~=game.Players.LocalPlayer then ab.updatePlayerESP(ai,Color3.fromRGB(0,255,0),ag,Color3.fromRGB(255,0,255))end end end ad:
CreateToggle{Name='Player ESP',CurrentValue=true,Flag=nil,Callback=function(ah)ag=ah UpdatePlrESP()end}task.spawn(function()while task.wait(1)do for ai,aj in
pairs(ac.getExits())do local ak=ac.getExitTrigger(aj)if ak then ak.Size=Vector3.new(20,20,20)end end end end)local ai=true local function updatePCESP()for aj,ak
in pairs(ac.getCurrentMapChildren())do if ak.Name=='ComputerTable'and ak:FindFirstChild'Screen'then ab.updateESP(ak,ak.Screen.Color,ai)end end end ad:
CreateToggle{Name='Computer ESP',CurrentValue=true,Flag=nil,Callback=function(aj)ai=aj updatePCESP()end}local ak=not ab.isDev()local function updateLockerESP()
local al=ac.getLockers()for am,an in pairs(al)do ab.updateESP(an,Color3.fromRGB(255,255,0),ak)end end ad:CreateToggle{Name='Locker ESP',CurrentValue=ak,Flag=nil
,Callback=function(al)ak=al updateLockerESP()end}task.spawn(function()while task.wait(1)do UpdateBeastESP()UpdatePlrESP()updatePCESP()updateLockerESP()end
UpdateBeastESP()UpdatePlrESP()updatePCESP()updateLockerESP()end)local am=aa.Window:CreateTab'Utils'am:CreateButton{Name='Fling Beast',Callback=function()local
an=ac.findBeast()if an then ab.flingPlayer(an)end end}local ao=false am:CreateToggle{Name='Slow Beast',CurrentValue=false,Flag=nil,Callback=function(ap)ao=ap
end}task.spawn(function()while task.wait()do if ao and not ac.isBeast()then local aq=ac.getPowerEvent()if aq then aq:FireServer'Jumped'end end end end)local aq=
false am:CreateToggle{Name='Make Beast Untie',CurrentValue=false,Flag=nil,Callback=function(ar)aq=ar end}task.spawn(function()while task.wait()do if aq then ac.
clickHammer()end end end)local as=false am:CreateToggle{Name='Auto Save',CurrentValue=false,Flag=nil,Callback=function(b)as=b end}local c=false task.spawn(
function()while task.wait()do if as and ac.isInGame()and not ac.isBeast()then local d=ac.getCurrentMapChildren()for e,f in pairs(d)do if f.Name=='FreezePod'then
local g=f:FindFirstChild'PodTrigger'if g then local h=g:FindFirstChild'CapturedTorso'if h.Value~=nil then ac.triggerPod(g)end end end end end end end)local d=
true am:CreateToggle{Name='Auto Tie',CurrentValue=true,Flag=nil,Callback=function(e)d=e end}task.spawn(function()while task.wait()do if d and ac.isBeast()then
local f=game:GetService'Players'.LocalPlayer local g=f and f.Character local h=g and g:FindFirstChild'HumanoidRootPart'if h then for i,j in pairs(game:
GetService'Players':GetPlayers())do if j~=f and not ab.isFriendsWith(j)and ac.isRagdoll(j)and not ac.isCaptured(j)then local k=j.Character and j.Character:
FindFirstChild'HumanoidRootPart'if k then if ab.dist3d(h.Position,k.Position)<=15 then ac.tiePlayer(j)end end end end end end end end)local f=ab.isDev()am:
CreateToggle{Name='Auto Hit',CurrentValue=f,Flag=nil,Callback=function(g)f=g end}task.spawn(function()while task.wait()do if f then local h=game:GetService
'Players'.LocalPlayer local i=h and h.Character local j=i and i:FindFirstChild'HumanoidRootPart'if j then for k,l in pairs(game:GetService'Players':GetPlayers()
)do if l~=h and not ab.isFriendsWith(l)and not ac.isRagdoll(l)and not ac.isCaptured(l)then local m=l.Character and l.Character:FindFirstChild'HumanoidRootPart'
if m then if ab.dist3d(j.Position,m.Position)<=15 then ac.hitPlayer(l)end end end end end end end end)local h=ab.isDev()am:CreateToggle{Name='Auto Beast',
CurrentValue=h,Flag=nil,Callback=function(i)h=i end}task.spawn(function()while task.wait()do if h and ac.isBeast()then local j=game:GetService'Players'.
LocalPlayer local k=j and j.Character local l=k and k:FindFirstChild'HumanoidRootPart'if l then local m=ac.getCapturablePlayers()for n,o in pairs(m)do local p=o
and o.Character local q=p and p:FindFirstChild'HumanoidRootPart'if q and l and not ab.isFriendsWith(o)then l.CFrame=q.CFrame task.wait(0.1)ac.hitPlayer(o)task.
wait(0.1)ac.tiePlayer(o)task.wait(0.1)ac.triggerNearestFreezePod()end end end end end end)local j=true am:CreateToggle{Name='No Errors',CurrentValue=true,Flag=
nil,Callback=function(k)j=k end}local l=true am:CreateToggle{Name='No Fog',CurrentValue=true,Flag=nil,Callback=function(m)l=m end}local n=true am:CreateToggle{
Name='Better Camera',CurrentValue=true,Flag=nil,Callback=function(o)n=o end}local p=false am:CreateToggle{Name='Avoid Beast',CurrentValue=p,Flag=nil,Callback=
function(q)p=q end}local r=false am:CreateToggle{Name='Auto Exit',CurrentValue=r,Flag=nil,Callback=function(s)r=s end}task.spawn(function()local t=false while
task.wait(1)do if t and not ac.isCloseToExit()then task.wait(10)t=false end if r and ac.isInGame()and not ac.isBeast()and not t then local u=ac.findOpenExit()if
u then local v,w=ac.getExitArea(u),game:GetService'Players'.LocalPlayer local x=w and w.Character local y=x and x:FindFirstChild'HumanoidRootPart'if y then y.
CFrame=v.CFrame t=true end end end end end)local t=false am:CreateToggle{Name='Auto Open Exit',CurrentValue=t,Flag=nil,Callback=function(u)t=u end}task.spawn(
function()local v=false while task.wait()do if v and not ac.isCloseToExit()then task.wait(10)v=false end if t and ac.isInGame()and not ac.isBeast()and not v
then local w=ac.findOpenExit()if w then return end local x=ac.getClosestClosedExit()if x then local y=ac.getExitTrigger(x)if y then local z=game:GetService
'Players'.LocalPlayer local A=z and z.Character local B=A and A:FindFirstChild'HumanoidRootPart'if B then B.CFrame=y.CFrame v=true end end end end end end)local
v,w,x,y=true,true,false y=am:CreateToggle{Name='Auto E',CurrentValue=true,Flag=nil,Callback=function(z)v=z if w and not z then y:Set(true)end end}local z z=am:
CreateToggle{Name='Easy Hack (Requires Auto E)',CurrentValue=true,Flag=nil,Callback=function(A)w=A if A then y:Set(true)end if x and not A then z:Set(true)end
end}am:CreateToggle{Name='Auto Hack (Requires Easy Hack)',CurrentValue=false,Flag=nil,Callback=function(A)x=A if A then z:Set(true)end end}local B=false task.
spawn(function()local C while task.wait(0.1)do local D,E=ac.isCloseToComputer()local F,H=ac.isCloseToFreezePod(),ac.isCloseToExit()if(ac.isInGame()and v and(D
or F or H))or(ac.isBeast()and v and F)and ac.shouldEasyHack()then game.ReplicatedStorage.RemoteEvent:FireServer('Input','Action',true)task.wait(0.1)game.
ReplicatedStorage.RemoteEvent:FireServer('Input','Action',false)end if ac.isInGame()and w and D and C~=E and not ac.isInDanger()and not B then local J=game:
GetService'Players'.LocalPlayer local K=J and J.Character local L=K and K:FindFirstChild'HumanoidRootPart'if L then local M=ac.getValidSpot(E)task.spawn(
function()local N=true task.spawn(function()while N and not ac.isInDanger()and not B do if M then L.CFrame=M.CFrame*CFrame.new(0,0,0.1)end task.wait()end end)
task.delay(1,function()N=false end)end)end end if ac.isInGame()and x and not ac.isInDanger()and not B then local J=ac.getClosestComputer(false)if not ab.
get_safeTweening()and J and J~=E then local K=ac.getValidSpot(J)if K then ab.set_safeTweening(true)task.delay(1,function()local L=game:GetService'Players'.
LocalPlayer local M=L and L.Character local _=M and M:FindFirstChild'HumanoidRootPart'ab.safeTweenToPart(K)end)end end end C=E end end)am:CreateKeybind{Name=
'Teleport to Freeze Pod',CurrentKeybind='F',HoldToInteract=false,Flag='FTFFreezePodKeybind',Callback=ac.teleportToNearestFreezePod}task.spawn(function()local F,
D,E=(Vector3.new(0,0,0))while task.wait()do if j then local G=ac.getStats(game:GetService'Players'.LocalPlayer)local H=G and G:FindFirstChild'ActionEvent'if H.
Value then game.ReplicatedStorage.RemoteEvent:FireServer('SetPlayerMinigameResult',true)end end if l then game:GetService'Lighting'.Atmosphere.Density=0 game:
GetService'Lighting'.Atmosphere.Offset=0 game:GetService'Lighting'.Atmosphere.Glare=0 game:GetService'Lighting'.Atmosphere.Haze=0 game:GetService'Lighting'.Blur
.Enabled=false game:GetService'Lighting'.DepthOfField.Enabled=false game:GetService'Lighting'.Brightness=2 game:GetService'Lighting'.ClockTime=14 game:
GetService'Lighting'.FogEnd=100000 game:GetService'Lighting'.GlobalShadows=false game:GetService'Lighting'.OutdoorAmbient=Color3.fromRGB(128,128,128)end if n
then local G=game:GetService'Players'.LocalPlayer if G then G.CameraMode=Enum.CameraMode.Classic G.CameraMaxZoomDistance=100 end end if p and not c then local G
=ac.findBeast()local H=G and G.Character local I,J=H and H:FindFirstChild'HumanoidRootPart',game:GetService'Players'.LocalPlayer local K=J and J.Character local
L=K and K:FindFirstChild'HumanoidRootPart'if H then if K then if ac.isInDanger()then if not B then D=L.CFrame E=L.Position game.Workspace.Gravity=0 ab.Noclip.
enable()task.wait(0.1)B=true end end end elseif B then L.CFrame=D game.Workspace.Gravity=196.2 ab.Noclip.disable()B=false end if B then local M=ab.dist3d(E,I.
Position)if M>=ac.beast_max_dist then L.CFrame=D game.Workspace.Gravity=196.21 ab.Noclip.disable()B=false else local N=I.CFrame*CFrame.new(0,-10,0)L.CFrame=N
for O,P in ipairs(K:GetDescendants())do if P:IsA'BasePart'then P.Velocity,P.RotVelocity=F,F end end end end elseif B then local G=game:GetService'Players'.
LocalPlayer local H=G and G.Character local I=H and H:FindFirstChild'HumanoidRootPart'if I then I.CFrame=D end game.Workspace.Gravity=196.21 ab.Noclip.disable()
B=false end end end)am:CreateSlider{Name='Chase Music Volume',Range={0,100},Increment=1,Suffix='%',CurrentValue=100,Flag='FTFChaseMusicVolume',Callback=function
(D)ac.updateChaseVolume(D)end}end return init end function a.n():typeof(__modImpl())local aa=a.cache.n if not aa then aa={c=__modImpl()}a.cache.n=aa end return
aa.c end end do local function __modImpl()local aa,ab=a.c(),{}function ab.getCurrentGun()local ac=game:GetService'Players'.LocalPlayer local ad=ac and ac.
Character local ae=ad and ad:FindFirstChildOfClass'Tool'return ae end function ab.getGunFireEvent()local ac=ab.getCurrentGun()local ad=ac and ac:FindFirstChild
'Events'local ae=ad and ad:FindFirstChild'Fire'return ae end function ab.getGunReloadEvent()local ac=ab.getCurrentGun()local ad=ac and ac:FindFirstChild'Events'
local ae=ad and ad:FindFirstChild'Reload'return ae end function ab.getGunAmmo()local ac=ab.getCurrentGun()local ad=ac and ac:FindFirstChild'GunServer'local ae=
ad and ad:FindFirstChild'Ammo'local af=(ae and ae.Value)or 0 return af end function ab.reloadGun()local ac=ab.getGunReloadEvent()if ac then ac:FireServer()end
end function ab.shootChar(ac)local ad,ae,af=ab.getGunFireEvent(),ac and ac:FindFirstChild'HumanoidRootPart',ac and ac:FindFirstChildWhichIsA'Humanoid'if ae and
af and ad then local ag,ah,ai=game:GetService'Players'.LocalPlayer:GetNetworkPing()/2,ae.AssemblyLinearVelocity,af and(af.MoveDirection*af.WalkSpeed)ah=ah:Lerp(
ai,0.6)local aj,ak=ae.Position+(ah*ag),Random.new()ad:FireServer{Origin=ae.Position,Timestamp=game.Workspace:GetServerTimeNow(),Direction=aa.dir3d(ae.Position,
aj),Seed=ak:NextInteger(0,100)}end end function ab.findClosestChar()local ac=game:GetService'Players'.LocalPlayer local ad=ac and ac.Character local ae=ad and
ad:FindFirstChild'HumanoidRootPart'if ae then local ag,af=99999999 for ah,ai in pairs(game:GetService'Players':GetPlayers())do if ai~=ac then local aj=ai and ai
.Character local ak,al,am=aj and aj:FindFirstChild'HumanoidRootPart',aj and aj:FindFirstChildOfClass'ForceField',aj and aj:FindFirstChildOfClass'Humanoid'if ak
and not al and(am and am.Health>0)then local an=aa.dist3d(ae.Position,ak.Position)if an<ag then af=aj ag=an end end end end return af end return nil end return
ab end function a.o():typeof(__modImpl())local aa=a.cache.o if not aa then aa={c=__modImpl()}a.cache.o=aa end return aa.c end end do local function __modImpl()
local function init()local aa,ab=a.f(),a.o()local ac,ad=aa.Window:CreateTab('Granny Shooters','gamepad-2'),true ac:CreateToggle{Name='Auto Kill',CurrentValue=ad
,Flag=nil,Callback=function(ae)ad=ae end}task.spawn(function()while task.wait()do if ad then local af=ab.findClosestChar()ab.shootChar(af)end end end)local af=
true ac:CreateToggle{Name='Auto Reload',CurrentValue=af,Flag=nil,Callback=function(ag)af=ag end}task.spawn(function()while task.wait()do if af then if ab.
getGunAmmo()==0 then ab.reloadGun()task.wait(5)end end end end)end return init end function a.p():typeof(__modImpl())local aa=a.cache.p if not aa then aa={c=
__modImpl()}a.cache.p=aa end return aa.c end end do local function __modImpl()local aa={}function aa.isSeeker(ab)local ac=ab and ab.Character local ad=ac and ac
:FindFirstChild'ItScript'return ad~=nil end return aa end function a.q():typeof(__modImpl())local aa=a.cache.q if not aa then aa={c=__modImpl()}a.cache.q=aa end
return aa.c end end do local function __modImpl()local function init()local aa,ab,ac=a.f(),a.c(),a.q()local ad=aa.Window:CreateTab('Hide and Seek','gamepad-2')
ad:CreateSection'ESP'local ae=true local function updatePlayerESP()for af,ag in pairs(game:GetService'Players':GetPlayers())do if ag~=game:GetService'Players'.
LocalPlayer then local ah=(ac.isSeeker(ag)and Color3.fromRGB(255,0,0))or Color3.fromRGB(0,255,0)ab.updatePlayerESP(ag,ah,ae,Color3.fromRGB(255,0,255))end end
end ad:CreateToggle{Name='Player ESP',CurrentValue=ae,Flag=nil,Callback=function(af)ae=af updatePlayerESP()end}task.spawn(function()while task.wait(1)do if ae
then updatePlayerESP()end end end)ad:CreateSection'Utils'ad:CreateButton{Name='Kill All',Callback=function()local ag=game:GetService'Players'.LocalPlayer local
ah=ag and ag.Character local ai=ah and ah:FindFirstChild'HumanoidRootPart'if ai then local aj=0 ab.Noclip.enable()while aj<10 do for ak,al in pairs(game:
GetService'Players':GetPlayers())do if al~=ag then local am=al and al.Character local an=am and am:FindFirstChild'HumanoidRootPart'if an then an.CFrame=ai.
CFrame end end end aj=aj+1 task.wait()end ab.Noclip.disable()end end}end return init end function a.r():typeof(__modImpl())local aa=a.cache.r if not aa then aa=
{c=__modImpl()}a.cache.r=aa end return aa.c end end do local function __modImpl()local aa,ab=a.c(),{}function ab.updatePlayerESP(ac)local ad,ae=aa.
getLocalPlayer(),ab.getCurrentGame()=='HideAndSeek'for af,ag in pairs(game:GetService'Players':GetPlayers())do local ah,ai=ag and ag.Character,ab.hasKnife(ag)
local aj=(ab.isGuard(ah)and Color3.fromRGB(0,0,255))or((ae and((ai and Color3.fromRGB(255,0,0))or Color3.fromRGB(0,255,0)))or Color3.fromRGB(255,0,0))if ag~=ad
then aa.updatePlayerESP(ag,aj,ac and ab.isAlive(ah),Color3.fromRGB(255,0,255))end end end function ab.updateGuardESP(ac)local ad=ab.getGuards()for ae,af in
pairs(ad)do aa.updateESP(af,Color3.fromRGB(0,0,255),ac and ab.isAlive(af))end end function ab.getLiving()local ac=game.Workspace:FindFirstChild'Live'return ac
end function ab.isPlayerGuard(ac)if not ac then return false end local ad=ac:FindFirstChild'GuardPlayerOutift'if ad then return true end return false end
function ab.isNPCGuard(ac)if not ac then return false end local ad=ac:FindFirstChild'TypeOfGuard'if ad then return true end return false end function ab.isGuard
(ac)return ab.isPlayerGuard(ac)or ab.isNPCGuard(ac)end function ab.getGuards()local ac,ad=ab.getLiving(),{}for ae,af in pairs(ac:GetChildren())do if ab.isGuard(
af)then table.insert(ad,af)end end return ad end function ab.getPlayerGuards()local ac,ad=ab.getGuards(),{}for ae,af in pairs(ac)do if ab.isPlayerGuard(af)then
table.insert(ad,af)end end return ad end function ab.getNPCGuards()local ac,ad=ab.getGuards(),{}for ae,af in pairs(ac)do if ab.isNPCGuard(af)then table.insert(
ad,af)end end return ad end function ab.isAlive(ac)local ad=ac and ac:FindFirstChild'Humanoid'if ad then return ad.Health>0 end return true end function ab.
getValues()local ac=game.Workspace:FindFirstChild'Values'return ac end function ab.getCurrentGame()local ac=ab.getValues()local ad=ac and ac:FindFirstChild
'CurrentGame'if ad then return ad.Value end return nil end function ab.getGlassBridge()local ac=game.Workspace:FindFirstChild'GlassBridge'return ac end function
ab.getGlassHolder()local ac=ab.getGlassBridge()local ad=ac and ac:FindFirstChild'GlassHolder'return ad end function ab.getGlassPanels()local ac=ab.
getGlassHolder()if ac then local ad=ac:GetChildren()return ad end return{}end function ab.getGlassModels(ac)if ac then local ad=ac:GetChildren()return ad end
return{}end function ab.getGlassPart(ac)local ad=ac and ac:FindFirstChild'glasspart'return ad end function ab.isFakeGlass(ac)local ad=ac and ac:FindFirstChild
'Blur'if ad then return true end return false end function ab.getGlassParts()local ac,ad={},ab.getGlassPanels()for ae,af in pairs(ad)do local ag=ab.
getGlassModels(af)for ah,ai in pairs(ag)do local aj=ab.getGlassPart(ai)if aj then table.insert(ac,aj)end end end return ac end function ab.updateGlassBridgeESP(
ac)local ad=ab.getGlassParts()for ae,af in pairs(ad)do local ag=ab.isFakeGlass(af)aa.updateESP(af,Color3.fromRGB(255,0,0),ac and ag)end end function ab.hasKnife
(ac)local ad,ae=ac and ac.Character,ac and ac:FindFirstChild'Backpack'local af=(ae and ae:FindFirstChild'Knife')or(ad and ad:FindFirstChild'Knife')if af then
return true end return false end function ab.getGunEvent()local ac=game:GetService'ReplicatedStorage':FindFirstChild'Remotes'local ad=ac and ac:FindFirstChild
'FiredGunClient'return ad end function ab.getMP5()local ac=aa.getLocalChar()local ad=ac and ac:FindFirstChild'MP5'return ad end function ab.silentShoot()local
ac,ad,ae,af,ag,ah,ai=ab.getMP5(),ab.getGunEvent(),CFrame.new(),Instance.new'Part',Vector3.new(),Vector3.new(1,1,1),Vector3.new()if ac and ad then ad:FireServer{
ac,{ClientRayNormal=Vector3.new(0,0,-1),FiredGun=true,bulletCF=ae,ClientRayInstance=af,SecondaryHitTargets={},ClientRayPosition=ag,HitTargets={},bulletSizeC=ah,
NoMuzzleFX=false,FirePosition=ai}}end end function ab.getDoll()local ac=game.Workspace:FindFirstChild'SQUIDDOLL123'return ac end function ab.gotoDoll()local ac=
ab.getDoll()if ac then local ad=aa.getLocalRoot()if ad then local ae=ac:FindFirstChildWhichIsA'BasePart'or ac:FindFirstChildWhichIsA'MeshPart'if ae then ad.
CFrame=ae.CFrame end end end end return ab end function a.s():typeof(__modImpl())local aa=a.cache.s if not aa then aa={c=__modImpl()}a.cache.s=aa end return aa.
c end end do local function __modImpl()local aa,ab,ac=a.s(),a.c(),{}ac.State={player_esp_toggled=true,guard_esp_toggled=true,glass_bridge_esp_toggled=true,
player_guard_tp_toggled=false,npc_guard_tp_toggled=false}function ac.onPlayerESPToggle(ad)ac.State.player_esp_toggled=ad aa.updatePlayerESP(ad)end task.spawn(
function()while task.wait(1)do if ac.State.player_esp_toggled then aa.updatePlayerESP(ac.State.player_esp_toggled)end end end)function ac.onGuardESPToggle(ad)ac
.State.guard_esp_toggled=ad aa.updateGuardESP(ad)end task.spawn(function()while task.wait(1)do if ac.State.guard_esp_toggled then aa.updateGuardESP(ac.State.
guard_esp_toggled)end end end)function ac.onGlassBridgeESPToggle(ad)ac.State.glass_bridge_esp_toggled=ad aa.updateGlassBridgeESP(ad)end task.spawn(function()
while task.wait(1)do if ac.State.glass_bridge_esp_toggled then aa.updateGlassBridgeESP(ac.State.glass_bridge_esp_toggled)end end end)function ac.
onPlayerGuardTPToggle()ac.State.player_guard_tp_toggled=not ac.State.player_guard_tp_toggled end function ac.onNPCGuardTPToggle()ac.State.npc_guard_tp_toggled=
not ac.State.npc_guard_tp_toggled end task.spawn(function()while task.wait()do if ac.State.player_guard_tp_toggled then local ad,ae=aa.getPlayerGuards(),ab.
getLocalRoot()if ae then for af,ag in pairs(ad)do local ah=ag and ag:FindFirstChild'HumanoidRootPart'if ah and aa.isAlive(ag)then ah.CFrame=ae.CFrame*CFrame.
new(0,0,-10)end end end end end end)task.spawn(function()while task.wait()do if ac.State.npc_guard_tp_toggled then local ad,ae=aa.getNPCGuards(),ab.
getLocalRoot()if ae then for af,ag in pairs(ad)do local ah=ag and ag:FindFirstChild'HumanoidRootPart'if ah and aa.isAlive(ag)then ah.CFrame=ae.CFrame*CFrame.
new(0,0,-10)end end end end end end)return ac end function a.t():typeof(__modImpl())local aa=a.cache.t if not aa then aa={c=__modImpl()}a.cache.t=aa end return
aa.c end end do local function __modImpl()local function init()local aa,ab=a.f(),a.t()local ac=aa.Window:CreateTab('Ink Game','gamepad-2')ac:CreateSection'ESP'
ac:CreateToggle{Name='Player ESP',CurrentValue=ab.State.player_esp_toggled,Flag=nil,Callback=ab.onPlayerESPToggle}ac:CreateToggle{Name='Guard ESP',CurrentValue=
ab.State.guard_esp_toggled,Flag=nil,Callback=ab.onGuardESPToggle}ac:CreateKeybind{Name='Bring Player Guards',CurrentKeybind='H',HoldToInteract=false,Flag=
'BringPlayerGuards',Callback=ab.onPlayerGuardTPToggle}ac:CreateKeybind{Name='Bring NPC Guards',CurrentKeybind='J',HoldToInteract=false,Flag='BringNPCGuards',
Callback=ab.onNPCGuardTPToggle}task.spawn(function()loadstring(game:HttpGet
[[https://raw.githubusercontent.com/wefwef34/inkgames.github.io/refs/heads/main/ringta.lua]])()end)end return init end function a.u():typeof(__modImpl())local
aa=a.cache.u if not aa then aa={c=__modImpl()}a.cache.u=aa end return aa.c end end do local function __modImpl()local aa,ab=a.c(),{}function ab.plrHasItem(ac,ad
)local ae,af=ac:FindFirstChild'Backpack',ac.Character local ag,ah=ae and ae:FindFirstChild(ad),af and af:FindFirstChild(ad)if ag or ah then return true end
return false end function ab.plrHasKnife(ac)return ab.plrHasItem(ac,'Knife')end function ab.plrHasGun(ac)return ab.plrHasItem(ac,'Gun')end local ac,ad task.
spawn(function()game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'Gameplay':WaitForChild'PlayerDataChanged'.OnClientEvent:Connect(function(
ae)ac=nil ad=nil for af,ag in pairs(ae)do local ah=game:GetService'Players':FindFirstChild(af)for ai,aj in pairs(ag)do if ai=='Role'then if aj=='Murderer'then
ac=ah end if aj=='Sheriff'then ad=ah end end end end end)game:GetService'ReplicatedStorage':WaitForChild'Remotes':WaitForChild'Gameplay':WaitForChild
'RoundEndFade'.OnClientEvent:Connect(function(ae)ac=nil ad=nil end)end)function ab.getMurderer()for ae,af in pairs(game:GetService'Players':GetPlayers())do if
ab.plrHasKnife(af)then ac=af break end end return ac end function ab.getSheriff()for ae,af in pairs(game:GetService'Players':GetPlayers())do if ab.plrHasGun(af)
then ad=af break end end return ad end function ab.shootPos(ae)local af=aa.getLocalPlayer()if ab.plrHasGun(af)then local ag,ah=aa.getLocalChar(),aa.
getLocalRoot()local ai=ag and ag:FindFirstChild'Gun'local aj=ai and ai:FindFirstChild'Shoot'if aj and ah then aj:FireServer(ah.CFrame,CFrame.new(ae))end end end
function ab.shootPlayer(ae)local af=ae and ae.Character local ag,_,ai=af and af:FindFirstChild'HumanoidRootPart',af and af:FindFirstChildWhichIsA'Humanoid',aa.
getLocalPlayer()if ai and ag then local aj,ak=ai:GetNetworkPing()*1.5,ag.AssemblyLinearVelocity local al=ag.Position+(ak*aj)ab.shootPos(al)end end function ab.
doMurderRaycast(ae,af)local ag,ah,ai=aa.getLocalChar(),(af-ae)-((af-ae).Unit*1.5),RaycastParams.new()ai.FilterType=Enum.RaycastFilterType.Exclude ai.
FilterDescendantsInstances={ag}ai.IgnoreWater=true local aj=game.Workspace:Spherecast(ae,1.5,ah,ai)if not aj then return true end return false end function ab.
getValidOffset(ae,af)for ag,ah in pairs(af)do local ai,aj=ae.Position+ah,ae.Position if ab.doMurderRaycast(ai,aj)then return ah end end return Vector3.new(0,0,0
)end function ab.getShotPos(ae)local af,ag=aa.getLocalRoot(),ae and ae.Character local ah,ai=ag and ag:FindFirstChild'HumanoidRootPart',{Vector3.new(0,0,-15),
Vector3.new(0,0,15),Vector3.new(0,-15,0),Vector3.new(0,15,0),Vector3.new(-15,0,0),Vector3.new(15,0,0)}if af and ah then local aj=ab.getValidOffset(ah,ai)return
ah.CFrame*CFrame.new(aj)end return nil end function ab.tpShoot(ae)local af,ag,ah=aa.getLocalPlayer(),aa.getLocalRoot(),ae and ae.Character local ai,aj=ah and ah
:FindFirstChild'HumanoidRootPart',af:GetNetworkPing()if ag and ai then local ak=ag.CFrame task.wait(0.1)local al=ab.getShotPos(ae)ag.CFrame=al task.wait(aj*2)ab
.shootPlayer(ae)task.wait(aj*2)ag.CFrame=ak end end function ab.updatePlayerESP(ae)local af,ag=ab.getMurderer(),ab.getSheriff()for ah,ai in pairs(game:
GetService'Players':GetPlayers())do if ai~=game:GetService'Players'.LocalPlayer then local aj,ak=ai==af,ai==ag if ak then aa.updatePlayerESP(ai,Color3.fromRGB(0
,0,255),ae,Color3.fromRGB(255,0,255))elseif aj then aa.updatePlayerESP(ai,Color3.fromRGB(255,0,0),ae,Color3.fromRGB(255,0,255))else aa.updatePlayerESP(ai,Color3
.fromRGB(0,255,0),ae,Color3.fromRGB(255,0,255))end end end end function ab.updateCoinESP(ae)local af=game.Workspace:FindFirstChild('CoinContainer',true)if af
then for ag,ah in pairs(af:GetChildren())do if ah.Name=='CollectedCoin'then ah:Destroy()end end aa.updateESP(af,Color3.fromRGB(255,200,0),ae)end end function ab
.flingMurderer()local ae=ab.getMurderer()if ae and ae~=game:GetService'Players'.LocalPlayer then aa.flingPlayer(ae)end end function ab.killAll()local ae=game:
GetService'Players'.LocalPlayer local af=ae and ae.Character local ag,ah=af and af:FindFirstChild'Humanoid',af and af:FindFirstChild'HumanoidRootPart'if ag then
local ai=ae:FindFirstChild'Backpack'local aj=ai and ai:FindFirstChild'Knife'if aj then ag:EquipTool(aj)task.wait()end local ak=ae.Character:FindFirstChild
'Knife'if ak then task.spawn(function()local al=true task.spawn(function()task.wait(1)al=false end)while al do for am,an in pairs(game:GetService'Players':
GetPlayers())do local ao=an.Character local ap=ao and ao:FindFirstChild'HumanoidRootPart'if ao and an~=game:GetService'Players'.LocalPlayer and not aa.
isFriendsWith(an)then ap.CFrame=ah.CFrame*CFrame.new(0,0,-3)end end task.wait()end end)task.wait()ak:Activate()end end end return ab end function a.v():typeof(
__modImpl())local aa=a.cache.v if not aa then aa={c=__modImpl()}a.cache.v=aa end return aa.c end end do local function __modImpl()local function init()local aa,
ab,ac=a.f(),a.c(),a.v()local ad=aa.Window:CreateTab('Murder Mystery 2','gamepad-2')ad:CreateSection'ESP'local af=true ad:CreateToggle{Name='Player ESP',
CurrentValue=true,Flag=nil,Callback=function(ag)af=ag ac.updatePlayerESP(ag)end}game:GetService'RunService'.RenderStepped:Connect(function()if af then ac.
updatePlayerESP(af)end end)local ah=true ad:CreateToggle{Name='Coin ESP',CurrentValue=true,Flag=nil,Callback=function(ai)ah=ai ac.updateCoinESP(ai)end}game:
GetService'RunService'.RenderStepped:Connect(function()if ah then ac.updateCoinESP(ah)end end)ad:CreateSection'Utils'ad:CreateButton{Name='Kill All (Murderer)',
Callback=ac.killAll}local al=false ad:CreateToggle{Name='Auto Kill All',CurrentValue=false,Flag=nil,Callback=function(am)al=am end}task.spawn(function()while
task.wait()do if al then ac.killAll()task.wait(4)end end end)ad:CreateKeybind{Name='Shoot Murderer',CurrentKeybind='G',HoldToInteract=false,Flag=
'MMShootMurdererKeybind',Callback=function()local an=ac.getMurderer()if an then ac.tpShoot(an)end end}local ao=true ad:CreateToggle{Name='Auto Grab Gun',
CurrentValue=true,Flag=nil,Callback=function(ap)ao=ap end}task.spawn(function()while task.wait()do if ao then local aq,ar=game.Workspace:FindFirstChild(
'GunDrop',true),ab.getLocalRoot()if aq and ar then if not ab.isDev()then task.wait(0.1)end aq.CFrame=ar.CFrame end end end end)ad:CreateButton{Name=
'Fling Murderer',Callback=function()ac.flingMurderer()end}local ar=false ad:CreateToggle{Name='Auto Fling Murderer',CurrentValue=false,Flag=nil,Callback=
function(as)ar=as end}task.spawn(function()while task.wait()do if ar then local b=ac.getMurderer()if b then ac.flingMurderer()task.wait(4)end end end end)local
b=false ad:CreateToggle{Name='Collect Coins',CurrentValue=false,Flag=nil,Callback=function(c)b=c end}task.spawn(function()local function coinCollected(d)local e
=d:FindFirstChild'CoinVisual'if not e then return true end local f=e:FindFirstChild'MainCoin'if not f then return true end if f.Transparency>0 then return true
end return false end while task.wait()do if b and not ab.get_safeTweening()then local d=game:GetService'Players'.LocalPlayer local e=d and d.Character local f=e
and e:FindFirstChild'HumanoidRootPart'if f then local g=game.Workspace:FindFirstChild('CoinContainer',true)if g then local i,h=99999999 for j,k in pairs(g:
GetChildren())do if k.Name=='Coin_Server'and not coinCollected(k)then local l=ab.dist3d(f.Position,k.Position)if l<i and l>1 then i=l h=k end end end if h then
ab.set_safeTweenSpeed(22)ab.safeTweenToPart(h,coinCollected)end end end end end end)task.spawn(function()while task.wait(0.1)do local d=game.Workspace:
FindFirstChild('Base',true)local e=d and d:FindFirstChild'GlitchProof'if e then e:Destroy()end end end)end return init end function a.w():typeof(__modImpl())
local aa=a.cache.w if not aa then aa={c=__modImpl()}a.cache.w=aa end return aa.c end end do local function __modImpl()local aa,ab=a.c(),{}function ab.getZombies
()local ac=game.Workspace:FindFirstChild'Zombies'return(ac and ac:GetChildren())or{}end function ab.getBox()local ac=game.Workspace:FindFirstChild'Interactions'
return ac and ac:FindFirstChild'Mystery'end function ab.getPack()local ac=game.Workspace:FindFirstChild'Interactions'return ac and ac:FindFirstChild
'Pack-a-Punch'end function ab.getPowerups()local ac=game.Workspace:FindFirstChild'Power-ups'return(ac and ac:GetChildren())or{}end function ab.updateZombieESP(
ac)local ad=ab.getZombies()for ae,af in pairs(ad)do aa.updateESP(af,Color3.fromRGB(255,0,255),ac)end end function ab.updateBoxESP(ac)local ad=ab.getBox()if ad
then aa.updateESP(ad,Color3.fromRGB(255,255,0),ac)end end function ab.updatePowerupESP(ac)local ad=ab.getPowerups()for ae,af in pairs(ad)do aa.updateESP(af,
Color3.fromRGB(107,176,255),ac)end end return ab end function a.x():typeof(__modImpl())local aa=a.cache.x if not aa then aa={c=__modImpl()}a.cache.x=aa end
return aa.c end end do local function __modImpl()local function init()local aa,ab=a.f(),a.x()local ac=aa.Window:CreateTab('Reminiscence Zombies','gamepad-2')ac:
CreateSection'ESP'local ae=true ac:CreateToggle{Name='Zombie ESP',CurrentValue=true,Flag=nil,Callback=function(af)ae=af ab.updateZombieESP(af)end}local ag=true
ac:CreateToggle{Name='Box ESP',CurrentValue=true,Flag=nil,Callback=function(ah)ag=ah ab.updateBoxESP(ah)end}local ai=true ac:CreateToggle{Name='Powerup ESP',
CurrentValue=true,Flag=nil,Callback=function(aj)ai=aj ab.updatePowerupESP(aj)end}game:GetService'RunService'.RenderStepped:Connect(function()if ae then ab.
updateZombieESP(ae)end if ag then ab.updateBoxESP(ag)end if ai then ab.updatePowerupESP(ai)end end)ac:CreateSection'Utils'ac:CreateKeybind{Name='TP to Box',
CurrentKeybind='X',HoldToInteract=false,Flag='RZGotoBoxKeybind',Callback=function()local al=ab.getBox()if al then local am=al.PrimaryPart or al:
FindFirstChildWhichIsA'BasePart'if am then local an=game:GetService'Players'.LocalPlayer local ao=an and an.Character local ap=ao and ao:FindFirstChild
'HumanoidRootPart'if ap then ap.CFrame=am.CFrame end end end end}ac:CreateKeybind{Name='TP to Pack',CurrentKeybind='Z',HoldToInteract=false,Flag=
'RZGotoPackKeybind',Callback=function()local am=ab.getPack()if am then local an=am.PrimaryPart or am:FindFirstChildWhichIsA'BasePart'if an then local ao=game:
GetService'Players'.LocalPlayer local ap=ao and ao.Character local aq=ap and ap:FindFirstChild'HumanoidRootPart'if aq then aq.CFrame=an.CFrame end end end end}
local an=true ac:CreateToggle{Name='Bring Zombies (Right Click)',CurrentValue=true,Flag=nil,Callback=function(ao)an=ao end}task.spawn(function()local ap=game:
GetService'Players'.LocalPlayer local aq,ar=ap and ap:GetMouse(),false if aq then aq.Button2Down:Connect(function()ar=true end)aq.Button2Up:Connect(function()ar
=false end)end game:GetService'RunService'.RenderStepped:Connect(function()if an and ar then local as=ab.getZombies()for b,c in pairs(as)do local d=c:
FindFirstChild'HumanoidRootPart'or c.PrimaryPart if d then local e=game:GetService'Players'.LocalPlayer local f=e and e.Character local g=f and f:FindFirstChild
'HumanoidRootPart'if g then d.CFrame=g.CFrame*CFrame.new(0,0,-5)end end end end end)end)local ap=true ac:CreateToggle{Name='Auto Grab Powerups',CurrentValue=
true,Flag=nil,Callback=function(aq)ap=aq end}game:GetService'RunService'.RenderStepped:Connect(function()if ap then local ar=ab.getPowerups()for as,b in pairs(
ar)do local c=game:GetService'Players'.LocalPlayer local d=c and c.Character local e,f=d and d:FindFirstChild'HumanoidRootPart',b.PrimaryPart or b:
FindFirstChildWhichIsA'BasePart'if f and e then f.CFrame=e.CFrame end end end end)end return init end function a.y():typeof(__modImpl())local aa=a.cache.y if
not aa then aa={c=__modImpl()}a.cache.y=aa end return aa.c end end do local function __modImpl()local aa,ab=a.c(),{}function ab.updateAnimalESP(ac)local ad=game
.Workspace:FindFirstChild'Gameplay'local ae=ad and ad:FindFirstChild'Dynamic'local af=ae and ae:FindFirstChild'Animals'local ag=af and af:GetChildren()for ah,ai
in pairs(ag)do aa.updateESP(ai,Color3.fromRGB(0,128,255),ac)end end function ab.getTeam()local ac=game:GetService'Players'.LocalPlayer return(ac and ac.Team)or{
Name='Not in game'}end function ab.isAnimal()return ab.getTeam().Name=='Animal'end function ab.isKeeper()return ab.getTeam().Name=='Keeper'end function ab.
isInGame()return ab.getTeam().Name~='Not in game'end function ab.getKeeper()for ac,ad in pairs(game:GetService'Players':GetPlayers())do if ad.Team.Name==
'Keeper'then return ad end end return nil end function ab.getClosestAnimal()local ac=game:GetService'Players'.LocalPlayer local ad=ac and ac.Character local ae,
af,ah,ag=ad and ad:FindFirstChild'HumanoidRootPart',game:GetService'Players':GetPlayers(),99999999 for ai,aj in pairs(af)do local ak=aj.Character local al=ak
and ak:FindFirstChild'HumanoidRootPart'if al and ae then local am=aa.dist3d(ae.Position,al.Position)if am<ah and aj~=ac and aj.Team.Name=='Animal'then ah=am ag=
aj end end end return ag end function ab.getPlayersAnimal(ac)local ad=ac and ac.Character local ae=ad and ad:FindFirstChild'HumanoidRootPart'if ae then local af
=game.Workspace:FindFirstChild'Gameplay'local ag=af and af:FindFirstChild'Dynamic'local ah=ag and ag:FindFirstChild'Animals'local ai=ah and ah:GetChildren()if
ai then local ak,aj=99999999 for al,am in pairs(ai)do local an=am.PrimaryPart if an then local ao=aa.dist3d(ae.Position,an.Position)if ao<ak then ak=ao aj=am
end end end return aj end end return nil end return ab end function a.z():typeof(__modImpl())local aa=a.cache.z if not aa then aa={c=__modImpl()}a.cache.z=aa
end return aa.c end end do local function __modImpl()local function init()local aa,ab,ac=a.f(),a.c(),a.z()local ad=aa.Window:CreateTab('ZOO or OOF','gamepad-2')
ad:CreateSection'ESP'local af=true ad:CreateToggle{Name='Animal ESP',CurrentValue=true,Flag=nil,Callback=function(ag)af=ag ac.updateAnimalESP(ag)end}game:
GetService'RunService'.RenderStepped:Connect(function()if af then ac.updateAnimalESP(af)end end)ad:CreateSection'Farm'local ai=true ad:CreateToggle{Name=
'Auto Farm',CurrentValue=true,Flag=nil,Callback=function(aj)ai=aj end}task.spawn(function()local ak=false while task.wait()do if ai then if ak and not ac.
isInGame()then ak=false end if ac.isAnimal()and not ak then local al=game:GetService'Players'.LocalPlayer local am=al and al.Character local an=am and am:
FindFirstChild'HumanoidRootPart'if an then task.wait((ab.isDev()and 1)or 2)an.CFrame=CFrame.new(1,51,224)task.wait(1)ak=true end end if ak then local al=ac.
getKeeper()if al then local am=game:GetService'Players'.LocalPlayer local an=am and am.Character local ao,ap=an and an:FindFirstChild'HumanoidRootPart',al.
Character local aq=ap and ap:FindFirstChild'HumanoidRootPart'if ao and aq then ao.CFrame=aq.CFrame local ar={[1]='Taunt.play'}game:GetService'ReplicatedStorage'
.Net:FireServer(unpack(ar))end end end else ak=false end end end)local ak=true ad:CreateToggle{Name='Auto Kill',CurrentValue=true,Flag=nil,Callback=function(al)
ak=al end}task.spawn(function()while task.wait()do if ac.isKeeper()and ak then local am=game:GetService'Players'.LocalPlayer local an=am and am.Character local
ao,ap=an and an:FindFirstChild'HumanoidRootPart',ac.getClosestAnimal()if ap and ao then local aq=ac.getPlayersAnimal(ap)local ar=aq and aq.PrimaryPart if ar
then local as={[1]='Shooting.shotPlayer',[2]=ao.CFrame,[3]=ar.CFrame,[4]=ap,[5]=ar,[6]=CFrame.new(0.8038291931152344,0.09816551208496094,-8.88824462890625E-4)*
CFrame.Angles(3.1407759189605713,1.3910810947418213,3.129187822341919)}game:GetService'ReplicatedStorage'.Net:FireServer(unpack(as))end end end end end)end
return init end function a.A():typeof(__modImpl())local aa=a.cache.A if not aa then aa={c=__modImpl()}a.cache.A=aa end return aa.c end end do local function 
__modImpl()local aa,ab=a.c(),{}function ab.updatePlayerESP(ac)local ad=aa.getLocalPlayer()for ae,af in pairs(game:GetService'Players':GetPlayers())do if af~=ad
then aa.updatePlayerESP(af,af.TeamColor.Color,ac,Color3.fromRGB(255,0,255))end end end return ab end function a.B():typeof(__modImpl())local aa=a.cache.B if not
aa then aa={c=__modImpl()}a.cache.B=aa end return aa.c end end do local function __modImpl()local aa,ab,ac=a.B(),a.c(),{}ac.player_esp_toggled=true ac.teleports
={{Name='Criminal Hideout',Position=Vector3.new(-989,94,2039),Callback=function(ad)ac.teleportTo(ad.Position)end}}function ac.teleportTo(ad)local ae=ab.
getLocalRoot()if ae then ae.CFrame=CFrame.new(ad)end end function ac.onPlayerESPToggle(ad)ac.player_esp_toggled=ad aa.updatePlayerESP(ad)end task.spawn(function
()while task.wait()do if ac.player_esp_toggled then aa.updatePlayerESP(ac.player_esp_toggled)end end end)return ac end function a.C():typeof(__modImpl())local
aa=a.cache.C if not aa then aa={c=__modImpl()}a.cache.C=aa end return aa.c end end do local function __modImpl()local function init()local aa,ab=a.f(),a.C()
local ac=aa.Window:CreateTab('Prison Life','gamepad-2')ac:CreateSection'ESP'ac:CreateToggle{Name='Player ESP',CurrentValue=true,Flag=nil,Callback=ab.
onPlayerESPToggle}ac:CreateSection'Teleports'for ad,ae in pairs(ab.teleports)do ac:CreateButton{Name=ae.Name,Callback=function()ae:Callback()end}end end return
init end function a.D():typeof(__modImpl())local aa=a.cache.D if not aa then aa={c=__modImpl()}a.cache.D=aa end return aa.c end end do local function __modImpl(
)for aa,ab in pairs{{a.i(),7585283196},{a.l(),10148749921},{a.n(),372226183},{a.p(),10141757860},{a.r(),93740418},{a.u(),7008097940},{a.w(),66654135},{a.y(),
1003981402},{a.A(),7785400752},{a.D(),73885730}}do if game.GameId==ab[2]then task.spawn(ab[1])break end end return true end function a.E():typeof(__modImpl())
local aa=a.cache.E if not aa then aa={c=__modImpl()}a.cache.E=aa end return aa.c end end do local function __modImpl()local aa,ab=a.f(),{}local ac=aa.Window:
CreateTab('Externals','telescope')ac:CreateSection'Dex'ab.dex_injected=false ab.iy_injected=false ab.rs_injected=false ac:CreateButton{Name='Inject Dex',
Callback=function()if ab.dex_injected then return end ab.dex_injected=true task.spawn(function()loadstring(game:HttpGet
[[https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua]])()end)end}ab.DexToggle=ac:CreateToggle{Name='Load Dex on Startup',CurrentValue=
false,Flag='LoadDexOnStartup',Callback=function(ae)end}ac:CreateSection'Infinite Yield'ac:CreateButton{Name='Inject IY',Callback=function()if ab.iy_injected
then return end ab.iy_injected=true task.spawn(function()loadstring(game:HttpGet[[https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source]])()end)
end}ab.IYToggle=ac:CreateToggle{Name='Load IY on Startup',CurrentValue=false,Flag='LoadIYOnStartup',Callback=function(af)end}ac:CreateSection'Cobalt Spy'ac:
CreateButton{Name='Inject Cobalt Spy',Callback=function()if ab.rs_injected then return end ab.rs_injected=true task.spawn(function()loadstring(game:HttpGet
[[https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau]])()end)end}ab.RSToggle=ac:CreateToggle{Name='Load Cobalt on Startup',CurrentValue=
false,Flag='LoadRSOnStartup',Callback=function(ag)end}return ab end function a.F():typeof(__modImpl())local aa=a.cache.F if not aa then aa={c=__modImpl()}a.
cache.F=aa end return aa.c end end do local function __modImpl()local aa,ab=a.f(),a.c()local ac,ad=aa.Window:CreateTab'Emotes',{{Name='Take The L',Id=
93090980853782},{Name='UFO',Id=120449791578755},{Name='Fake Dead',Id=73689381418785},{Name='67 Body',Id=82296043272517},{Name='Obby Head',Id=122814100170962},{
Name='Floating',Id=131950236025472},{Name='Katseye',Id=100829635809504},{Name='Floating Headless',Id=98728517497209},{Name='Levitate',Id=111499780397123},{Name=
'67',Id=88672473602461},{Name='Hide',Id=117450501566142},{Name='Biblically Accurate',Id=133596366979822},{Name='Best Mates',Id=113016438012253},{Name='Car',Id=
71229119391920},{Name='Dab',Id=114366486943553},{Name='Tank',Id=109896367267714},{Name='Heart',Id=100501857801770},{Name='Plane',Id=111917372615551},{Name=
'Headless',Id=74738520664045},{Name='NLE',Id=133293268056643},{Name='Zesty Backflip',Id=91510776097850},{Name='Throw It In A Circle',Id=85405186226004},{Name=
'Cute Bouncy Jiggly Shake',Id=97975134806779},{Name='Hip',Id=98287740564271},{Name='Cute sitting with legs out',Id=89755161074689},{Name='Kawaii Sitting Cutely'
,Id=134682231294570},{Name='Cute Profile Pose',Id=129838364671769},{Name='Kicking Feet Sit',Id=92676668301699},{Name='Daydreaming',Id=89174456614428},{Name=
'Feet Kicking',Id=78224683906191},{Name='Bouncy Circle Shake',Id=118582721407059},{Name='Nya San',Id=118688124889191},{Name='Splits',Id=137064024843676},{Name=
'Caramelldansen',Id=97847706148165},{Name='Kawaii Wiggling',Id=98074497797170},{Name='Iron Mouse',Id=96409366076000}}local function getTrueId(ae)local af,ag,ah=
(ab.getLocalHumanoid())ag=af.AnimationPlayed:Connect(function(ai)if ai.Animation and ai.Animation.AnimationId~=''then ah=ai.Animation.AnimationId ai:Stop()end
end)local ai=af:WaitForChild'HumanoidDescription'ai:AddEmote(ae.Name,ae.Id)af:PlayEmote(ae.Name)local aj=0 while not ah and aj<2 do task.wait(0.1)aj+=0.1 end if
ag then ag:Disconnect()end return ah end local ae local function stopAnimations()if ae then ae:Stop()ae=nil end end ac:CreateButton{Name='Stop Emote',Callback=
stopAnimations}ac:CreateSection'Emotes'for af,ag in pairs(ad)do ac:CreateButton{Name=ag.Name,Callback=function()local ah=ab.getLocalHumanoid()local ai=ah:
FindFirstChild'Animator'stopAnimations()local aj,ak=Instance.new'Animation',getTrueId(ag)if ak then print(ak)aj.AnimationId=ak ae=ai:LoadAnimation(aj)ae.Looped=
true ae.Priority=Enum.AnimationPriority.Action4 ae:Play()else warn'Failed to add emote'end end}end return true end function a.G():typeof(__modImpl())local aa=a.
cache.G if not aa then aa={c=__modImpl()}a.cache.G=aa end return aa.c end end end local aa=a.c()aa.WaitForGameAndPlayer()local ab=a.f()a.g()a.E()local ac=a.F()a
.G()ab.Library:LoadConfiguration()if ac.DexToggle.CurrentValue then ac.dex_injected=true task.spawn(function()loadstring(game:HttpGet
[[https://github.com/AZYsGithub/DexPlusPlus/releases/latest/download/out.lua]])()end)end if ac.IYToggle.CurrentValue then ac.iy_injected=true task.spawn(
function()loadstring(game:HttpGet[[https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source]])()end)end if ac.RSToggle.CurrentValue then ac.
rs_injected=true task.spawn(function()loadstring(game:HttpGet[[https://github.com/notpoiu/cobalt/releases/latest/download/Cobalt.luau]])()end)end