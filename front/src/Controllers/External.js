import ViewNavbar from '../Views/Navbar.js';
import ViewExternal from '../Views/External.js';

import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';

export default class ControllerExternal {
    constructor() {
        document.body.innerHTML = `<header id="navbar"></header>
<section id="external"></section>
<div id="notifications"></div>`;
        this.angle = 0;

        this.animate = this.animate.bind(this);

        this.colors = {
            "Aucune":"pink",
            "Rouge":"red",
            "Vert":"lime",
            "Bleu":"blue",
            "Jaune":"yellow",
            "Rose":"pink",
        }

        this.run();
    }

    loadModel(model) {
        const loader = new GLTFLoader();
        this.model = model;
        loader.load(
            model,
            (gltf) => {
                const model = gltf.scene;
                model.scale.set(2, 2, 2);
                model.position.set(0, 0, 0);
                model.rotation.set(0, Math.PI - Math.PI / 6, -Math.PI / 6);
                this.scene.add(model);
            },
            (xhr) => {
                console.log(`Loading: ${(xhr.loaded / xhr.total * 100).toFixed(1)}%`);
            },
            (error) => {
                console.error('Loading error:', error);
            }
        );
    }

    unloadModel() {
        this.scene.remove(this.model);
    }

    animate() {
        requestAnimationFrame(this.animate);

        const baseSpeed = 0.05;
        const minSpeed = 0;
        const slowdownAngle = Math.PI / 2 + Math.PI / 3;
        const slowdownWidth = Math.PI / 4;

        let dist = Math.abs(Math.sin((this.angle - slowdownAngle) / 2));
        
        let slowdownFactor = 1 - Math.exp(-Math.pow(dist / slowdownWidth, 2));

        let speed = minSpeed + (1 - slowdownFactor) * (baseSpeed - minSpeed);

        this.angle += speed;

        this.camera.position.x = 10 * Math.cos(this.angle);
        this.camera.position.z = 10 * Math.sin(this.angle);
        this.camera.lookAt(0, 0, 0);

        this.renderer.render(this.scene, this.camera);
    }

    attachScene() {
        const canvas = document.querySelector('.condom-3d');

        this.scene = new THREE.Scene();
        const aspect = canvas.clientWidth / canvas.clientHeight;
        const frustumSize = 5;

        this.camera = new THREE.OrthographicCamera(
            -frustumSize * aspect / 2,
            frustumSize * aspect / 2,
            frustumSize / 2,
            -frustumSize / 2,
            0,
            100
        );
        this.camera.position.set(0, 0, 0);
        this.camera.lookAt(0, 0, 0);

        this.renderer = new THREE.WebGLRenderer({ canvas, alpha: true, antialias: true });
        this.renderer.setSize(canvas.clientWidth, canvas.clientHeight);

        const light = new THREE.DirectionalLight(0xffffff, 2);
        light.position.set(1, 1, -1).normalize();
        this.scene.add(light);

        const light2 = new THREE.DirectionalLight(0xffffff, 2);
        light2.position.set(-1, -1, 2).normalize();
        this.scene.add(light2);

        const ambientLight = new THREE.AmbientLight(0xffffff, 1);
        this.scene.add(ambientLight);

        this.loadModel('Condom/packaging/pink.glb');

        this.animate();
    }

    attachForm() {
        
    }

    async run() {
        await this.render();

        this.colorSelect = document.querySelector('#color');

        this.colorSelect.addEventListener('change', (e) => {
            const color = e.target.value;

            this.unloadModel();

            const modelPath = `Condom/packaging/${this.colors[color]}.glb`;

            this.loadModel(modelPath);
        });

        this.attachScene();
    }

    async render() {
        new ViewNavbar('#navbar');
        const external = new ViewExternal('#external');
        await external.ready;
    }
}
