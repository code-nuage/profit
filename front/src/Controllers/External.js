import ViewNavbar from '../Views/Navbar.js';
import ViewExternal from '../Views/External.js';

import * as THREE from 'three';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';

export default class ControllerExternal {
    constructor() {
        document.body.innerHTML = `<header id="navbar"></header>
<section id="external"></section>`;
        this.run();
    }

    run() {
    this.render();

    const canvas = document.querySelector('.condom-3d');

    const scene = new THREE.Scene();
    const camera = new THREE.PerspectiveCamera(75, canvas.clientWidth / canvas.clientHeight, 0.1, 1000);
    camera.position.set(5, 0, 0);
    camera.lookAt(0, 0, 0);
    console.log(camera.position);

    const renderer = new THREE.WebGLRenderer({ canvas, alpha: true, antialias: true });
    renderer.setSize(canvas.clientWidth, canvas.clientHeight);

    const light = new THREE.DirectionalLight(0xffffff, 1);
    light.position.set(1, 1, 1).normalize();
    scene.add(light);
    const ambientLight = new THREE.AmbientLight(0xffffff, 0.5);
    scene.add(ambientLight);

    const geometry = new THREE.BoxGeometry(2, 2, 2); // cube 2x2x2
    const material = new THREE.MeshStandardMaterial({ color: 0xff0000 }); // rouge bien visible
    const cube = new THREE.Mesh(geometry, material);
    cube.position.set(0, 0, 0);
    // scene.add(cube);

    const loader = new GLTFLoader(); // pas THREE.GLTFLoader !
    loader.load(
        'Condom/base.glb',
        function (gltf) {
            const model = gltf.scene;
            model.scale.set(100, 100, 100);
            model.position.set(0, 0, 0);
            scene.add(model);
            console.log(model.position);
            animate();
        },
        function (xhr) {
            console.log(`Chargement : ${(xhr.loaded / xhr.total * 100).toFixed(1)}%`);
        },
        function (error) {
            console.error('Erreur de chargement GLB, chef :', error);
        }
    );

    let angle = 0;

    function animate() {
        requestAnimationFrame(animate);
        angle += 0.0025; // vitesse de rotation

        // Position de la caméra qui tourne autour de l'axe Y à une distance de 5
        camera.position.x = 5 * Math.cos(angle);
        camera.position.z = 5 * Math.sin(angle);

        camera.lookAt(0, 0, 0); // toujours regarder vers le centre
        renderer.render(scene, camera);
    }

    animate();
}

    render() {
        new ViewNavbar('#navbar');
        new ViewExternal('#external');
    }
}
